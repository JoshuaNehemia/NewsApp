import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { HttpService } from '../http-service';
import { AlertController, ToastController } from '@ionic/angular';

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'],
  standalone: false,
})
export class LoginPage implements OnInit {
  email = '';
  password = '';

  constructor(
    private http: HttpService,
    private router: Router,
    private toastCtrl: ToastController,
    private alertCtrl: AlertController
  ) {}

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
  async showRegisterOptions() {
    const alert = await this.alertCtrl.create({
      header: 'Daftar Sebagai',
      message: 'Pilih jenis akun yang ingin Anda buat.',
      buttons: [
        {
          text: 'Pembaca (User)',
          handler: () => {
            this.router.navigate(['/register']);
          },
        },
        {
          text: 'Penulis (Writer)',
          handler: () => {
            this.router.navigate(['/register-writer']);
          },
        },
        {
          text: 'Batal',
          role: 'cancel',
        },
      ],
    });

    await alert.present();
  }
}
