# AruraLabs Home Assignment

## Introduction


## how to run
### Parameters
this image comes with a pre-built user as admin, please set the username (`JENKINS_ADMIN_ID`) and password (`JENKINS_ADMIN_PASSWORD`) in the `.env` file
(default is `admin` and `admin`).  
If you wish to change the jenkins url please use the `JENKINS_HOST` variable in the `.env` file.
`GITHUB_REPO_DEST` is the name of the github repository to listen to (where we will configure the webhook) - please set it accordingly.  
There is a pre-built job configured named "Github Listener", this job will listen to Github webhooks and will trigger a build when a merge is made to the repository.  
please use the following link to add a webhook to your repository: `https://docs.github.com/en/developers/webhooks-and-events/webhooks/creating-webhooks`  

**please note** the webhook suffix needs to be `/github-webhook/`<br>
for sake of simplicity and because my repo was public no github credentials stored in the configuration  

`GITHUB_REPO_JOB_DSL` is the name of my public repository containing the main.py script.  

### Running the image
once done please clone this repository locally and cd to containing directory.  
you can run the following command to start the jenkins server:
`docker-compose --env-file .env up -d --build `
