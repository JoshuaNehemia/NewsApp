import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { HttpService } from '../http-service';

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'],
  standalone: false,
})
export class LoginPage implements OnInit {
  email = '';
  password = '';

  constructor(private http: HttpService, private router: Router) {}

  ngOnInit() {}

  onLogin() {
    this.http.login_user(this.email, this.password).subscribe((res: any) => {
      if (res.status === 'success') {
        localStorage.setItem('user_data', JSON.stringify(res.data));
        this.http.emitUserLogin(res.data);
        this.router.navigate(['/home']);
      } else {
        alert('Login Gagal: ' + res.message);
      }
    });
  }
}
