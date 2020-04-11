# DevOps Engineer - Technical Test	

## Usage

### One time Jenkins setup

Build a docker image for a simple local jenkins:

```bash
docker build -t localjenkins .
```

Then run it. The following assumes you have valid AWS credentials configured locally:

```bash
docker run -p 8080:8080 -v $HOME/.aws/credentials:/var/jenkins_home/.aws/credentials:ro localjenkins:latest
```

- Note the initial admin password printed to stdout

- Navigate to http://localhost:8080, unlock Jenkins with the initial password, and install suggested plugins.

- Create a local admin user using the form and start jenkins

- Navigate to Manage Jenkins > Manage Plugins. Select the Available tab, search and install Blue Ocean. Restart Jenkins if it doesn't automatically.

- Log back in. Open Blue Ocean and create a pipeline. Select git and use https://github.com/steveparker-1984/devops-test.git for the URL. It should not need a credential setting.

- A build will trigger automatically. See Build section below for more information.

- Navigate to http://localhost:8080/job/devops-test/configure select **Scan Multibranch Pipeline Triggers** and set `Periodically if not otherwise run` to 1 minute. In a real world scenario we might use webhooks instead.

### Build

The build asks for a parameter to launch or delete. These correlate with sceptre commands, which is a cli tool which assists with deploying CloudFormation. When you launch, an initial stack will be launched containing prerequisites: a vpc setup and an assets bucket. Typically these would already exist outside of this pipeline.

The app is then packaged and pushed to the s3 assets bucket. The package in s3 is timestamped. 

The package is then fed into the second cloudformation stack for deployment. This stack contains deploys the main app components, including a load balancer and autoscaling group, and supporting resources.

The pipeline prints the load balancer DNS name. You can curl or browse this to see the output. Application load balancer target groups use round robin by default.

In this form every build triggers a re-deploy of instances. In a real pipeline I'd prefer more build artefact management. It could be built in one pipeline and then deployed to an environment with another pipeline. I'm not really a fan of using userdata to configure an instance - I would probably package any complex app using packer for ease and speed of deployment.

Beyond this, I would typically have more build params for deploying to different environments and accounts. There are Jenkins plugins that facilitate this using `withAWS` directives.

Under the `config/` directory, I am just using a `dev/` directory. I would have different directories for deployment environments, containing any environmental params.