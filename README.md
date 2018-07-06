# walkmenode
<p>See a preview here</p>
<a href="http://www.youtube.com/watch?feature=player_embedded&v=xHo3GI9y34k
" target="_blank"><img src="http://img.youtube.com/vi/xHo3GI9y34k/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>
<p><a href="https://github.com/rfpoulos/walkmereact">See the front end code here</a> (front-end is written in React-Redux)</p>
<h2>Background</h2>
    <p>This server has exactly two post requests that do not require the front end to send a valid token in the header of their request; sign in and create account.  This means that in order to use any of the primary features of the applcation, users MUST be signed in.</p>
<h2>How to Set Up Your .env File</h2>
    <p>DB_PATH=postgres://<strong>{insert_username}</strong>@localhost:5432/pc</p>
    <p>SIGNATURE=<strong>{insert_any_password}</strong></p>
<h2>Verification API Requests</h2>
    <p>As mentioned in background, these are the only request that do not require a header with a valid token.</p>
        <h3>Create Account POST Request</h3>
            <p>When there is a post request to <em>localhost:5000/createaccount</em>, the server expects an object with a email, username, and password.  Here is an example:</p>
            <h6>
                {<br>
                    "password": "password",<br>
                    "username": "testusername",<br>
                    "email": "email@email.com"<br>
                }
            </h6>
            <p>All passwords are entered hashed and salted into the database.  If the username and/or email is already in the database, it will reject the account because usernames must be unique.  When a user is successfuly added, the server will respond with the string:</p>
            <h6>'User added.'</h6>
        <h3>Sign In POST Request</h3>
            <p>When there is a post request to <em>localhost:5000/signin</em>, the server expects an identifier and password to be in the body.  The identifier can be either the user's username or email.  Here is an example:</p>
            <h6>
                {<br>
                    "password": "password",<br>
                    "identifier": "testusername@test.com"<br>
                }
            </h6>
            <p>If the sign-in is in the database (passwords are stored as hashes with salt) i.e. valid, the server will respond with a userObject.  For example</p>
            <h6>
                {<br>
                    "id": 10,<br>
                    "username": "sampleuser",<br>
                    "email": "testusername@test.com",<br>
                    "thumbnail": "images/thumbnails/sampleuser",<br>
                    "location": "Atlanta, GA",<br>
                    "aboutme": "I love walking tours!",<br>
                    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1MjUzODQ0NTksImV4cCI6MTUyNTk4OTI1OX0.bXSEEFnDKKSp56ECdgmzde7PRCoCtBSNu-M4B5hT_Bc"<br>
                } 
            </h6>
            <p>Else, the server will respond with the string:</p>
            <h6>'Invalid identifier and/or password.'</h6>
<h2>RESTful API Requests</h2>
    <h3>GET Requests</h3>
        <h4>User</h4>
            <p>The user id is part of the payload of the token. So to get user information, just put the token in the header.  The path is <em>localhost:5000/user</em>.  Here is a sample return object.</p>
            <h6>
                {<br>
                    "id": 4,<br>
                    "username": "test",<br>
                    "email": "test@email.com",<br>
                    "location": "Atlanta, GA"<br>
                    "thumbnail": null,<br>
                    "aboutme": null<br>
                }
          <h4>Walk Guide or Title Autocomplete<h4>
            <p>Send a request to <em>/getguideortitle/:search</em>, and the search param will return a list of guidenames or titles of walks that contains the search (wildcards on each side).  Only the names are returned, nothings else.</p>
          <h4>Walk information by Username or Guidename</h4>
            <p>Send a request to <em>/getresultclick/:search</em> to return all the walk card information for the indicated result.  Best if you use a result returned from the Walk Guide or Title function indicated above.</p>
        <h4>Get Walk Pois</h4>
            <p>Send in the request the id of the walk which you want the related pois to <em>/getwalkpois/:id</em>.  The poi information will come back in an array ordered by their position.</p>
        <h4>Get contributed walks</h4>
            <p>By using the user id from the token sent to <em>/getcontributedwalks</em>, server will return all the walks created by the user.  Each array will have a walk object with the following:</p>
            <h6>id, thumbnail, description,
        length, public (true or false), title, address, username,
        users thumbnail as guidethumbnail, lat, long</h6>
        <h4>Get results within designated distance</h4>
            <p>To get all the walks within a designated distance, send a request to <em>/getresultswithindistance/:lat/:long/:miles/:limit/:sortby</em> where the lat and long represent the distance to calculate from, miles indicated how far from start location should be included in the results, the limit is how many total results to return, and sortby can be either <strong>length</strong> or <strong>distance</strong>.</p>
        <h4>Get walk by id</h4>
            <p>To get all walk information by id, send a request to <em>/getwalk/:id</em>.</p>
        <h4>Get user profile</h4>
            <p>To get all info to populate a user profile page, send a request to <em>/getprofile/:username</em>.</p>
    <h3>POST Requests</h3>
        <h4>Profile Picture</h4>
            <p>To update a profile picture, send a post request to <em>localhost:5000/postprofilepic</em>.  The file must come in an instance of a FormDate class with the file appended to the name 'thumbnail'.  The header cannot have a "Content-Type".  The server will respond with the path to the uploaded image.</p>
    <h3>PUT Requests</h3>
    <h3>DELETE Requests</h3>
