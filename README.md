# AruraLabs Home Assignment


[how to run](#how to run)  
[Introduction](#Introduction) 


## how to run
### Parameters
this image comes with a pre-built user as admin, please set the username (`JENKINS_ADMIN_ID`) and password (`JENKINS_ADMIN_PASSWORD`) in the `.env` file
(default is `admin` and `admin`).  
If you wish to change the jenkins url please use the `JENKINS_HOST` variable in the `.env` file.
`GITHUB_REPO_DEST` is the name of the github repository to listen to (where we will configure the webhook) - please set it accordingly.  
There is a pre-built job configured named "Github Listener", this job will listen to Github webhooks and will trigger a build when a merge is made to the repository.  
please use the following link to add a webhook to your repository: `https://docs.github.com/en/developers/webhooks-and-events/webhooks/creating-webhooks`  
I used `ngrok` as stated [here](https://docs.github.com/en/developers/webhooks-and-events/webhooks/creating-webhooks#exposing-localhost-to-the-internet)
to expose my local jenkins server to the internet with port 8080.
**please note** the webhook suffix needs to be `/github-webhook/`<br>
for sake of simplicity and because my repo was public no github credentials stored in the configuration  

`GITHUB_REPO_JOB_DSL` is the name of my public repository containing the main.py script.  

### Running the image
once done please clone this repository locally and cd to containing directory.  
you can run the following command to start the jenkins server:
`docker-compose --env-file .env up -d --build `

## Introduction
I used JCasC (jenkins configuration as code) to configure the jenkins server.
disabled the setup wizard and added a pre-built user with admin privileges.
need plugins are in the `plugins.txt` file you can add more if needed (installed when image built).
jenkins url set to `http://localhost:8080` (can be changed in the `.env` file).  
all jenkins configurations defined in the `configAsCode.yaml` file.  
note - I specified **allowsSignup: false**, which prevents anonymous users from creating an account through the web interface.  
because the user and password are defined in .env and will be and Environment Variable you can use the config yaml in source control repository safely.
I've used the Matrix Authorization Strategy plugin to define the permissions for the admin user.
I'm granting the `Overall/Administer` permissions to the admin user. You’re also granting `Overall/Read` permissions to authenticated, which is a special role that represents all authenticated users.  
To prevent privilege escalation simply by defining and running a malicious job or pipeline I used authorize-project plugin to define the permissions for the job as `strategy: triggeringUsersAuthorizationStrategy`.
To enable Agent to Controller Access Control I used the `remotingSecurity:enabled: true`.  
in the Dockerfile it is based on multi-stage build with base of python (to run the python script on built in node)  

all tested locally on my machine. if there are any issues please let me know.