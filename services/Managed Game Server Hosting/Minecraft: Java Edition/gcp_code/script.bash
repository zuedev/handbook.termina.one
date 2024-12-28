#!/bin/bash

# Create a new Compute Engine instance named 'minecraft-java-edition-instance'
gcloud compute instances create minecraft-java-edition-instance \
    # Specify the project ID
    --project=zuedev-catchall-2024 \
    # Set the zone where the instance will be created
    --zone=europe-west2-c \
    # Define the machine type (VM size)
    --machine-type=e2-medium \
    # Configure network interface settings
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    # Set metadata for OS configuration and OS login
    --metadata=enable-osconfig=TRUE,enable-oslogin=true,enable-oslogin-2fa=true \
    # Allow IP forwarding
    --can-ip-forward \
    # Set maintenance policy to migrate VM instances
    --maintenance-policy=MIGRATE \
    # Use standard provisioning model
    --provisioning-model=STANDARD \
    # Specify the service account to be used by the instance
    --service-account=211474278397-compute@developer.gserviceaccount.com \
    # Define OAuth 2.0 scopes for the instance
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append \
    # Create and configure the boot disk
    --create-disk=boot=yes,device-name=minecraft-java-edition-instance,image=projects/debian-cloud/global/images/debian-12-bookworm-v20241210,mode=rw,size=25,type=pd-ssd \
    # Enable shielded VM features
    --shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring \
    # Add labels to the instance
    --labels=goog-ops-agent-policy=v2-x86-template-1-4-0,goog-ec-src=vm_add-gcloud \
    # Set reservation affinity to 'any'
    --reservation-affinity=any \
    # Enable deletion protection
    --deletion-protection && \
# Create a config file for Ops Agent policy
printf 'agentsRule: \n  packageState:  installed\n  version:  latest\ninstanceFilter: \n  inclusionLabels: \n  - labels: \n      goog-ops-agent-policy:  v2-x86-template-1-4-0\n' > config.yaml && \
# Create an Ops Agent policy using the config file
gcloud compute instances ops-agents policies create goog-ops-agent-v2-x86-template-1-4-0-europe-west2-c \
    # Specify the project ID
    --project=zuedev-catchall-2024 \
    # Set the zone
    --zone=europe-west2-c \
    # Use the created config file
    --file=config.yaml