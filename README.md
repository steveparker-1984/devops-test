# DevOps Engineer - Technical Test	
We think infrastructure is best represented as code, and provisioning of resources should be automated as much as possible.	

 Your task is to create a CI build pipeline that deploys this web application to a load-balanced	
environment. You are free to complete the test in a local environment (using tools like Vagrant and	
Docker) or use any CI service, provisioning tool and cloud environment you feel comfortable with (we	
recommend creating a free tier account so you don't incur any costs).	

 * Your CI job should:	
  * Run when a feature branch is pushed to Github (you should fork this repository to your Github account). If you are working locally feel free to use some other method for triggering your build.	
  * Deploy to a target environment when the job is successful.	
* The target environment should consist of:	
  * A load-balancer accessible via HTTP on port 80.	
  * Two application servers (this repository) accessible via HTTP on port 3000.	
* The load-balancer should use a round-robin strategy.	
* The application server should return the response "Hi there! I'm being served from {hostname}!".	

 ## Context	
We are testing your ability to implement modern automated infrastructure, as well as general knowledge of system administration. In your solution you should emphasize readability, maintainability and DevOps methodologies.	

 ## Submit your solution	
Create a public Github repository and push your solution in it. Commit often - we would rather see a history of trial and error than a single monolithic push. When you're finished, send us the URL to the repository.	

 ## Running this web application	
 This is a NodeJS application:	This is a NodeJS application:

- `npm test` runs the application tests	- `npm test` runs the application tests
- `npm start` starts the http server


## Usage

### One time Jenkins setup

Build a docker image for jenkins

```bash
docker build -t localjenkins .
```

Then run it

```bash
docker run -p 8080:8080 -v $HOME/.aws/credentials:/var/jenkins_home/.aws/credentials:ro localjenkins:latest
```

- Note the initial admin password printed to stdout

- Navigate to http://localhost:8080, unlock Jenkins with the initial password, and install suggested plugins.

- Create a local admin user using the form and start jenkins

- Navigate to Manage Jenkins > Manage Plugins. Select the Available tab, search and install Blue Ocean.

- Open Blue Ocean, create a pipeline. Select git and use https://github.com/steveparker-1984/devops-test.git for the URL. For credential, enter your github username and a personal access token.

- A build will trigger automatically. See Build section below for more info

### Build

