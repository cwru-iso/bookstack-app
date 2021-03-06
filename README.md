# bookstack-app
AWS Elastic Beanstalk PHP deployment package for [BookStack](https://www.bookstackapp.com/).

This allows for easy scability by mounting a EFS volume to share uploads across
multiple instances.

**WARNING: The BookStack source code is NOT included!**

## Usage
Elastic BeanStalk will automatically run `composer install` when you deploy your application.

1. Clone the repo:  
`git clone https://github.com/cwru-iso/bookstack-app.git`

2. Run the build script within the repo:  
`cd bookstack-app && ./build.sh`

3. Upload the zip file to your Elastic Beanstalk application/environment.

4. Configure your environment based on your requirements.  
See: [BookStack hardware requirements](https://www.bookstackapp.com/#features).

## Environment
Larvel can use global environment variables instead of the ones in `.env`, so it is
recommended to use this (via Elastic Beanstalk) for any adjusting any settings. Below are
minimum required values that must be set for proper functionality.

See the files in [.ebextensions](.ebextensions) for more information.

### BookStack
* `APP_KEY` - Larvel application key; generate this beforehand.  
`php artisan key:generate --show`

* `APP_URL` - Recommended to be set as the **real** publicly accessible URL
for your BookStack environment.  
This is required if you plan to use any 3rd-party login options.

* `DB_HOST` - IP/Hostname and port of the database server.  
eg: `127.0.0.1:3306`, `db.host.com:3306`, etc.

* `DB_DATABASE` - Name of the database for BookStack.  

* `DB_USERNAME` - BookStack database username.  

* `DB_PASSWORD` - BookStack database password.

### EFS
* `EFS_FILE_SYSTEM_ID` - Elastic File System ID; must be in the same region and subnet(s).

## License
See [LICENSE](./LICENSE).

## Credit
* [BookStack](https://www.bookstackapp.com/)
* [Amazon Web Services](https://aws.amazon.com/)

## Author
Kyle Colantonio  
`kyle [.] colantonio @ case [.] edu`  
Case Western Reserve University