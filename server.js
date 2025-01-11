require('dotenv').config();
const express = require('express');
const session = require('express-session');
const pgSession = require('connect-pg-simple')(session);
const { Pool } = require('pg');
const bcrypt = require('bcrypt');
const path = require('path');
const ejs = require('ejs');
const { userInfo } = require('os');

const app = express();
const port = process.env.PORT || 3000;

// Database connection
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Session middleware
app.use(session({
  store: new pgSession({
    pool: pool,
    tableName: 'session'
  }),
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: false,
  cookie: { maxAge: 30 * 24 * 60 * 60 * 1000 } // 30 days
}));

// Authentication middleware
const authenticateUser = (req, res, next) => {
  if (req.session.userId) {
    next();
  } else {
    res.redirect('/login');
  }
};

// Routes
app.get('/', (req, res) => {
  res.render('index');
});

app.get('/register', (req, res) => {
  res.render('register');
});

app.post('/register', async (req, res) => {
  const { name, username, password } = req.body;
  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    await pool.query(
      'INSERT INTO users (name, username, password, created_by) VALUES ($1, $2, $3, $4)',
      [name, username, hashedPassword, 'system']
    );
    res.redirect('/login');
  } catch (error) {
    console.error(error);
    res.status(500).send('Error registering user');
  }
});

const redirectIfAuthenticated = (req, res, next) => {
  if (req.session.userId) {
    return res.redirect('/dashboard');
  }
  next();
};

app.get('/login', (req, res) => {
  res.render('login');
});

app.post('/login', redirectIfAuthenticated, async (req, res) => {
  const { username, password } = req.body;
  try {
    const result = await pool.query('SELECT * FROM users WHERE username = $1', [username]);
    if (result.rows.length > 0) {
      const user = result.rows[0];
      if (await bcrypt.compare(password, user.password)) {
        req.session.userId = user.id;
        req.session.userLevel = user.user_level;
        return res.redirect('/dashboard');
      } else {
        return res.status(400).send('Invalid credentials');
      }
    } else {
      return res.status(400).send('Invalid credentials');
    }
  } catch (error) {
    console.error(error);
    return res.status(500).send('Error logging in');
  }
});


app.get('/logout', (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      console.error(err);
    }
    res.redirect('/login');
  });
});

app.get('/dashboard', authenticateUser, async (req, res) => {
  try {
    let salesQuery = 'SELECT * FROM sales';
    let quotationsQuery = 'SELECT * FROM quotation';
    let companyQuery = 'SELECT * FROM company';
    let usersQuery = `SELECT * from users`; 
    let currentUser = `SELECT * from users where id = ${req.session.userId} `
    let financialTarget = `SELECT * FROM public.financial_target`;

    
    if (req.session.userLevel !== '1') {
      financialTarget += ` WHERE user_id = ${req.session.userId} order by financial_year desc `;
    }


    
    // const salesResult = await pool.query(salesQuery, req.session.userRole !== 'admin' ? [req.session.userId] : []);
    // const quotationsResult = await pool.query(quotationsQuery, req.session.userRole !== 'admin' ? [req.session.userId] : []);

    const salesResult = await pool.query(salesQuery);
    const quotationsResult = await pool.query(quotationsQuery);
    const companyresult = await pool.query(companyQuery);
    const userResult = await pool.query(usersQuery)
    const currentUserResult = await pool.query(currentUser)
    const financialTargetResult = await pool.query(financialTarget)


    
    
    res.render('dashboard', { 
      sales: salesResult.rows, 
      quotations: quotationsResult.rows,
      company: companyresult.rows,
      userDetail: userResult.rows,
      currentUser: currentUserResult.rows[0],
      financialTarget: financialTargetResult.rows,
      userLevel: req.session.userLevel,
      userId: req.session.userId

    });
  } catch (error) {
    console.error(error);
    res.status(500).send('Error fetching dashboard data');
  }
});

app.post("/updateUserAccount", async (req,res) => {
  const { name, username, id ,updatedBy} = req.body;
  try {
    await pool.query(
      'update users set name= $1, username = $2, updated_by = $3, updated_date = $4 where id = $5',
      [name, username, updatedBy, new Date(), id]
    );
    res.redirect('/dashboard');
  } catch (error) {
    console.error(error);
    res.status(500).send('Error updating user account');
  }
})

// Start server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

