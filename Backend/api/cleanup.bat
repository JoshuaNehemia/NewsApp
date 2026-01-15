@echo off
echo Menghapus file debug dan setup yang tidak terpakai...

del /F /Q debug_all_cats.php
del /F /Q debug_cats.php
del /F /Q debug_check_7.php
del /F /Q debug_db.php
del /F /Q debug_last_cats.php
del /F /Q debug_multi_test.php
del /F /Q debug_repo_detail_test.php
del /F /Q debug_repo_test.php
del /F /Q debug_verify_cats.php
del /F /Q test_registration.php
del /F /Q setup_db_images.php
del /F /Q setup_db_images_v2.php
del /F /Q setup_db_update.php

echo.
echo Selesai! File yang dihapus:
echo - 9 file debug_*.php
echo - 1 file test_registration.php
echo - 3 file setup_db_*.php
echo.
echo File debug_countries.php tetap ada (masih berguna).
pause
