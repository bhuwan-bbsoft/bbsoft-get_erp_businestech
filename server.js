require('dotenv').config();
const express = require('express');
const session = require('express-session');
const pgSession = require('connect-pg-simple')(session);
const { Pool } = require('pg');
const bcrypt = require('bcrypt');
const path = require('path');
const ejs = require('ejs');

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
    let companyQuery = 'SELECT * FROM company where id=1';
    let usersQuery = `SELECT * from users`; 
    let currentUser = `SELECT * from users where id = ${req.session.userId} `
    let financialTarget = `SELECT * FROM public.financial_target`;
    let allUserDetailsQuery = `select u.id,u.name, u.username,ul.name as role,s.name as status,ft.financial_year,ft.business_target, ft.achieved_till_date, ft.balance_to_go, ft.designation,ft.role as financial_role, ft.sales_manager  
                                   from users u
                                   inner join status s on s.level = u.status
                                   inner join user_level ul on ul.level = u.user_level
                                   inner join financial_target ft on ft.user_id = u.id`;

    
    if (req.session.userLevel !== '1') {
      financialTarget += ` WHERE user_id = ${req.session.userId} order by financial_year desc `;
    }


    
    // const salesResult = await pool.query(salesQuery, req.session.userRole !== 'admin' ? [req.session.userId] : []);
    // const quotationsResult = await pool.query(quotationsQuery, req.session.userRole !== 'admin' ? [req.session.userId] : []);

    const salesResult = await pool.query(salesQuery);
    const quotationsResult = await pool.query(quotationsQuery);
    const companyResult = await pool.query(companyQuery);
    const userResult = await pool.query(usersQuery)
    const currentUserResult = await pool.query(currentUser)
    const financialTargetResult = await pool.query(financialTarget)
    const allUserDetailsResult = await  pool.query(allUserDetailsQuery)

    console.log(allUserDetailsResult)
    
    
    res.render('dashboard', { 
      sales: salesResult.rows, 
      quotations: quotationsResult.rows,
      company: companyResult.rows[0],
      userDetail: userResult.rows,
      allUserDetails: allUserDetailsResult.rows,
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

app.post("/updateCompanyDetails", async (req,res) => {
  const {editCompanyName,editCompanyAddress,editCompanyCity,editCompanyState,editCompanyCountry,editCompanyMobile,
    editPinCode,editGSTNo,editCompanyEmail,editCompanyWebsite,editPanNumber,editFinancialYearBeginning,
    editBooksBeginning,editCurrency,editBankName,editAccountNumber,editIfsc,editBranch,editSwiftCode,
    editUpiId,editWhatsAppNumber,editInstanceId} = req.body;

  try{
    await pool.query(
        'UPDATE public.company ' +
          'SET name=$1, address=$2,  city=$3, state=$4, country=$5, mobile=$6, pincode=$7, gstin=$8, email=$9, ' +
          'website=$10, pan_number=$11, financial_year_beginning=$12, books_beginning=$13, currency=$14, bank_name=$15, account_number=$16, ' +
          'ifsc=$17, branch=$18, swift_code=$19, upi_id=$20, whatsapp_number=$21, instance_id=$22, updated_by=$23, updated_date=$24 WHERE id=$25',
        [editCompanyName,editCompanyAddress,editCompanyCity,editCompanyState,editCompanyCountry,editCompanyMobile,
          editPinCode,editGSTNo,editCompanyEmail,editCompanyWebsite,editPanNumber,editFinancialYearBeginning,
          editBooksBeginning,editCurrency,editBankName,editAccountNumber,editIfsc,editBranch,editSwiftCode,
          editUpiId,editWhatsAppNumber,editInstanceId, 'ADMIN',new Date(),'1'
        ]
    );
    res.redirect("/dashboard");
  }catch (error){
    console.log(error)
    res.status(500).send("Error in updating company details");
  }

})

app.post("/addNewUser", async (req,res) => {
  const { newName, newUserName, newPassword, newUserRole, newUserStatus, newFinancialYear,
    newBusinessTarget, newAchievedTillDate, newBalanceToGo, newDesignation, newRole, newSalesManager  } = req.body;

  try{
    await pool.query('BEGIN');

    // Insert into Users table and get the user_id
    const hashedPassword = await bcrypt.hash(newPassword, 10);
    const insertUserQuery = `INSERT INTO users( name, username, password, user_level, status, created_by, created_date) VALUES ($1, $2, $3, $4, $5, 'ADMIN', $6) RETURNING id`;
    const result = await pool.query(insertUserQuery, [newName, newUserName, hashedPassword,newUserRole, newUserStatus, new Date()]);
    const userId = result.rows[0].id;

    // Insert into financial target table using the user_id

    const insertFinancialTargetQuery = `INSERT INTO financial_target(user_id, financial_year, business_target, achieved_till_date, balance_to_go, designation, role, sales_manager) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`;
    await pool.query(insertFinancialTargetQuery, [userId, newFinancialYear, newBusinessTarget, newAchievedTillDate, newBalanceToGo, newDesignation, newRole, newSalesManager]);

    await pool.query('COMMIT');

    res.redirect('/dashboard')
  }catch (error){
    await pool.query('ROLLBACK');
    console.log(error)
    res.status(500).send("Error in creating new user");
  }
})

app.post("/editUserDetails", async (req,res) => {
  const { userId,editName, editUserName, editUserRole, editUserStatus, editFinancialYear,
    editBusinessTarget, editAchievedTillDate, editBalanceToGo, editDesignation, editRole, editSalesManager  } = req.body;

  try{
    await pool.query('BEGIN');

    const updateUserQuery = `UPDATE  users SET name=$1, username=$2, user_level=$3, status=$4, updated_by='ADMIN', updated_date=$5 where id=$6`;
    await pool.query(updateUserQuery, [editName,editUserName,editUserRole,editUserStatus,new Date(),userId]);

    const updateFinancialTargetQuery = `UPDATE financial_target SET financial_year=$1, business_target=$2, achieved_till_date=$3, balance_to_go=$4, designation=$5, role=$6, sales_manager=$7 where user_id=$8`;
    await pool.query(updateFinancialTargetQuery, [editFinancialYear,editBusinessTarget,editAchievedTillDate,editBalanceToGo,editDesignation,editRole,editSalesManager,userId]);

    await pool.query('COMMIT');

    res.redirect('/dashboard')
  }catch (error){
    await pool.query('ROLLBACK');
    console.log(error)
    res.status(500).send("Error in creating new user");
  }
})

app.post("/change-password", async (req,res) => {
  const {userId,username,newPassword} = req.body;

  const newUserName = username ? username: "ADMIN";
  try{
    const hashedPassword = await bcrypt.hash(newPassword, 10);
    const result  = await pool.query("update users set password=$1, updated_by=$2, updated_date=$3 where id=$4", [hashedPassword,newUserName, new Date(),userId]);

    if (result.rowCount > 0) {
      res.status(200).json({ success: true, message: 'Password changed successfully.' });
    } else {
      res.status(404).json({ success: false, message: 'User not found.' });
    }

  }catch (error){
    console.log(error);
    res.status(500).send("Error in changing password");
  }
})

// Start server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

