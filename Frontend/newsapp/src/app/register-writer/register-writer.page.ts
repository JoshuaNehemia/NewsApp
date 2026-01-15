import { Component, OnInit } from '@angular/core';
import { HttpService } from '../http-service';
import { Router } from '@angular/router';
import { ToastController } from '@ionic/angular';

@Component({
  selector: 'app-register-writer',
  templateUrl: './register-writer.page.html',
  styleUrls: ['./register-writer.page.scss'],
  standalone: false,
})
export class RegisterWriterPage implements OnInit {
  countries: any[] = [];
  confirmPassword: string = '';
  form = {
    username: '',
    password: '',
    fullname: '',
    email: '',
    biography: '',
    media_id: 1,
    profile_picture_address: 'default.png',
  };

  mediaList: any[] = [];

  constructor(
    private httpService: HttpService,
    private router: Router,
    private toastCtrl: ToastController
  ) {}

  ngOnInit() {
    this.loadMedias();
  }

  loadMedias() {
    this.httpService.getMedias().subscribe((res: any) => {
      if (res.status === 'success') {
        this.mediaList = res.data;
      }
    });
  }

  onRegister() {
    if (!this.form.username || !this.form.password || !this.form.media_id) {
      this.showToast('Mohon lengkapi data');
      return;
    }

    this.httpService.register_writer(this.form).subscribe(
      (res: any) => {
        if (res.status === 'success') {
          this.showToast('Registrasi Berhasil! Silakan Login.');
          this.router.navigate(['/login']);
        } else {
          this.showToast('Gagal: ' + res.message);
        }
      },
      (err: any) => {
        // Try to get error message from response
        let errorMessage = 'Terjadi kesalahan koneksi';
        if (err.error && err.error.message) {
          errorMessage = err.error.message;
        } else if (err.message) {
          errorMessage = err.message;
        }
        this.showToast(errorMessage);
      }
    );
  }

  async showToast(msg: string) {
    const toast = await this.toastCtrl.create({
      message: msg,
      duration: 2000,
    });
    toast.present();
  }
}
