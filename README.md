# walkmenode
<h2>Background</h2>
    <p>This server has exactly two post requests that do not require the front end to send a valid token in the header of their request; sign in and create account.  This means that in order to use any of the primary features of the applcation, users MUST be signed in.</p>
<h2>How to Set Up Your .env File</h2>
    <p>DB_PATH=postgres://<strong>{insert_username}</strong>@localhost:5432/pc</p>
    <p>SIGNATURE=<strong>{insert_any_password}</strong></p>
<h2>RESTful API Requests</h2>
    <h3>GET Requests</h3>
    <h3>POST Requests</h3>
        <h4>Verification</h4>
            <p>As mentioned in background, these are the only request that do not require a header with a valid token.</p>
            <h5>Create Account POST Request</h5>
                <p>When there is a post request to <em>localhost:3000/public/createaccount</em>, the server expects an object with a email, username, and password.  Here is an example:</p>
                <console>{
                	"password": "password",
                	"username": "testusername",
                    "email": "email@email.com"
                    }
                </console>
                <p>All passwords are entered hashed and salted into the database.  If the username and/or email is already in the database, it will reject the account because usernames must be unique.  When a user is successfuly added, the server will respond with the string:</p>
                <h6>'User added.'</h6>
    <h3>PUT Requests</h3>
    <h3>DELETE Requests</h3>