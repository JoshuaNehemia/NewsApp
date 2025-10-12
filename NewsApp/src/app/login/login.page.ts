import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { USERS } from '../data';

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'],
  standalone: false
})

export class LoginPage implements OnInit {
  
  username = '';
  password = '';
  loginError = false;
  loginSuccess = false;

  constructor(private router: Router) {}

  ngOnInit() {
    const isLoggedIn = localStorage.getItem('isLoggedIn');
    if (isLoggedIn === 'true') {
      const currentUrl = window.location.pathname;
      if (currentUrl.includes('/login')) {
        this.router.navigate(['/home']);
      }
    }
  }
  
  login() {
    const user = USERS.find(
      u => u.username === this.username && u.password === this.password
    );

    if (user) {
      localStorage.setItem('isLoggedIn', 'true');
      localStorage.setItem('currentUser', user.username);
      localStorage.setItem('currentName', user.name);
      this.loginSuccess = true;
      this.loginError = false;
      this.router.navigate(['/home']);

    } else {
      this.loginError = true;
      this.loginSuccess = false;
    }

  }

}
