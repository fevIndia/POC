### Prerequisites 

## Step 1: Install Docker 

  # Uninstall old versions
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
  
  # Add Docker's official GPG key:
    
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
  
  # Add the repository to Apt sources:
  
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
  
  # install the latest version
  
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  
## Step 2: Install kubectl

  sudo apt update
  sudo apt install kubectl


## Step 3: Install kind

# Linux (x86_64)
  curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.18.0/kind-linux-amd64
  chmod +x ./kind
  sudo mv ./kind /usr/local/bin/kind

## Step 4: Create a Kubernetes Cluster with kind using
  
  kind create cluster

## Step 5: Install Flux CLI
  
  brew install fluxcd/tap/flux


## Step 6: Install Flux on your Cluster
  
  flux install
 
## Step 7: Export your github credentials
  
  export GITHUB_TOKEN=<your-token>
  export GITHUB_USER=<your-username>


## Step 8: Create git repository using flux bootstrap command 
 
  flux bootstrap github \
    --owner=$GITHUB_USER \
    --repository=fluxcicd \
    --path=clusters/team-fluxcicd/flux-system \
    --branch=main \
    --personal \
    --namespace=team-fluxcicd
  

## Step 9: Clone git repository using git clone cmd.

  git clone <your repo URL>

## Step 10: Copy structure of fluxcicd in cloned folder and copy all yaml files as well.

## Step 11: Apply Notification Resources

  kubectl apply -f <name-of-file>.yaml in all yaml files

## Step 12: Push the repo in git
  
  git add . 
  git commit -m "commit" 
  git push origin main cmds.

## Step 13: Apply Notification Resources 

  kubectl apply -f <name-of-file>.yaml on all yaml files

## Step 14: Monitor status of kind git repository and kustomization using :

  flux get sources git -n flux-team-dev
  flux get kustomizations -n flux-team-dev

## Step 15: Trigger reconciliation if git repository and kustomization is getting false:

  flux reconcile source git team-dev-repo -n flux-team-dev
  flux reconcile kustomization team-dev-apps -n flux-team-dev


## Step 16: Install rocketchat using docker-compose

  git clone https://github.com/RocketChat/Docker.Official.Image.git
  cd Docker.Official.Image
  docker compose up -d

## Step 17: create a workspace and get webhook URL.

## Step 18: create a channel in rocketchat server e.g #fluxalert

## Step 19: Replace channel and address in rocketchat-provider.yaml file with your webhook URL and created channel

## Step 20: Create a pagerduty integration token using evnt API v2 

## Step 21: Replace channel in pager-duty-provider.yaml file from your integration key

## Step 22: Comment deployment.yaml file and push it in git repo

  git push

## Step 23: You should get alert notification in Pagerduty and rocketchat.




























