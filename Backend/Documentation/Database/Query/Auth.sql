-- login (One access login)
SELECT
    a.`username`          AS 'username',
    a.`password`          AS 'password',
    a.`fullname`          AS 'fullname',
    a.`email`             AS 'email',
    a.`role`              AS 'role',
    a.`is_active`         AS 'is_active',
    a.`locked_until`      AS 'locked_until',

    u.`birthdate`         AS 'user_birthdate',
    u.`gender`            AS 'user_gender',
    u.`phone_number`      AS 'user_phone_number',
    u.`biography`         AS 'user_biography',

    cu.`id`               AS 'user_country_id',
    cu.`code`             AS 'user_country_code',
    cu.`name`             AS 'user_country_name',
    cu.`telephone`        AS 'user_country_telephone',

    w.`biography`         AS 'writer_biography',
    w.`is_verified`       AS 'writer_is_verified',

    m.`id`                AS 'media_id',
    m.`name`              AS 'media_name',
    m.`slug`              AS 'media_slug',
    m.`company_name`      AS 'media_company_name',
    m.`media_type`        AS 'media_type',
    m.`picture_ext`       AS 'media_picture_ext',
    m.`logo_ext`          AS 'media_logo_ext',
    m.`website`           AS 'media_website',
    m.`email`             AS 'media_email',
    m.`description`       AS 'media_description',

    ct.`id`               AS 'media_city_id',
    ct.`name`             AS 'media_city_name',
    ct.`latitude`         AS 'media_city_latitude',
    ct.`longitude`        AS 'media_city_longitude',

    cd.`id`               AS 'media_country_division_id',
    cd.`name`             AS 'media_country_division_name',

    cm.`id`               AS 'media_country_id',
    cm.`code`             AS 'media_country_code',
    cm.`name`             AS 'media_country_name'

FROM `accounts` a

LEFT JOIN `users` u
    ON u.`username` = a.`username`
    AND a.`role` = 'user'

LEFT JOIN `countries` cu
    ON cu.`id` = u.`country_id`

LEFT JOIN `writers` w
    ON w.`username` = a.`username`
    AND a.`role` = 'writer'

LEFT JOIN `medias` m
    ON m.`id` = w.`media_id`

LEFT JOIN `cities` ct
    ON ct.`id` = m.`city_id`

LEFT JOIN `country_divisions` cd
    ON cd.`id` = ct.`country_division_id`

LEFT JOIN `countries` cm
    ON cm.`id` = cd.`country_id`

WHERE a.`username` = 'joshua123'
LIMIT 1;


-- Create Account
INSERT INTO `accounts` (`username`,`password`,`email`,`role`,`profile_picture_ext`) VALUES('najwa123','password','najwa@email.com','writer','jpg');

-- Create User
INSERT INTO `users` (`username`,`birthdate`,`gender`,`country_id`,`phone_number`,`biography`) VALUES('joshua123','2005-02-24','male',96,'8123409972','Halo gue orang keren');

-- Create Writer
INSERT INTO `writers` (`username`,`media_id`,`biography`) VALUES ('najwa123','13','Narasi');