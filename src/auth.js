import auth0 from 'auth0-js';

export default class Auth {
    auth0 = new auth0.WebAuth({
        domain: 'hyperdev.eu.auth0.com',
        clientID: 'fyrczeuCgQtw3QoukS19dT2wpCs7JqdF',
        redirectUri: 'http://hyperdev.local:8080/callback',
        audience: 'https://hyperdev.eu.auth0.com/userinfo',
        responseType: 'token id_token',
        scope: 'openid profile'
    });

    userprofile;

    constructor() {
        this.login = this.login.bind(this);
        this.logout = this.logout.bind(this);
        this.handleAuthentication = this.handleAuthentication.bind(this);
        this.isAuthenticated = this.isAuthenticated.bind(this);
        this.getProfile = this.getProfile.bind(this);
    }

    handleAuthentication() {
        this.auth0.parseHash((err, authResult) => {
            console.log("authResult", authResult)
            if (authResult && authResult.accessToken && authResult.idToken) {
                this.setSession(authResult);
                // history.replace('/home');
                window.location.href = "/"
            } else if (err) {
                // history.replace('/home');
                // window.location.href = "/err"
                console.log(err);
            }
        });
    }

    setSession(authResult) {
        // Set the time that the Access Token will expire at
        let expiresAt = JSON.stringify((authResult.expiresIn * 1000) + new Date().getTime());
        localStorage.setItem('access_token', authResult.accessToken);
        localStorage.setItem('id_token', authResult.idToken);
        localStorage.setItem('expires_at', expiresAt);
        // navigate to the home route
        // history.replace('/home');
        window.location.href = "/"
    }

    logout() {
        // Clear Access Token and ID Token from local storage
        localStorage.removeItem('access_token');
        localStorage.removeItem('id_token');
        localStorage.removeItem('expires_at');
        // navigate to the home route
        // history.replace('/home');
        window.location.href = "/"
    }

    isAuthenticated() {
        // Check whether the current time is past the
        // Access Token's expiry time
        let expiresAt = JSON.parse(localStorage.getItem('expires_at'));
        return new Date().getTime() < expiresAt;
    }

    getAccessToken() {
        const accessToken = localStorage.getItem('access_token');
        if (!accessToken) {
            throw new Error('No Access Token found');
        }
        return accessToken;
    }

    getProfile(cb) {
        let accessToken = this.getAccessToken();
        this.auth0.client.userInfo(accessToken, (err, profile) => {
            if (profile) {
                this.userProfile = profile;
            }
            cb(err, profile);
        });
    }

    login() {
        this.auth0.authorize();
    }
}