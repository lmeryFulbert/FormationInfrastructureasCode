cluster_name = ""
subnet_name  = ""
user         = ""
password     = ""
endpoint     = ""

#images
image_blocnames = ["imagedebian","imagecentos"]
image_names = ["Debian11Cloud","CentOS7Cloud"]
image_descriptions = ["Debian 11 Cloud","CentOS 7 Cloud"]
image_urls = [
              "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-genericcloud-amd64.qcow2",
              "http://download.nutanix.com/calm/CentOS-7-x86_64-GenericCloud.qcow2"
             ]

# nutanix vm cuustomization
vm_count = 2
vm_names = ["cloudDebian","cloudCentOS"]
vm_domain = "terra.local"
vm_user = "nutanix"
vm_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjeFBO6TTOREeZNoLQXkSkRlj/Eqba3OBME3ULRYlLUTk0TVeV98HdIfIEHKrMATBHY/r9epwaCU/jgNGbhttqii0GYcdex7ILTU3e4mdiyktjWY4NKnLSpmudNjdLHjPe6e/CY+vr26c18Yes8B2ve7yTgKKSQqDcTYfZ21MgTd2kWD6cUKbcSKY4Yb2P+Z95p9Cpbd1CNMgtgBnN4EB5rqLokk365fas7XzCbdPSJMYWgXnwofARmo90v7leKqBjoT7E1eqVPmdpclKK3Bt9tSTDofzBhd3F+ZxGy2ctfTmEG6uqo3X8qV2MooJVaWZQ1ac/GTisMZ397YL1h5GF"
vm_password="$6$4guEcDvX$HBHMFKXp4x/Eutj0OW5JGC6f1toudbYs.q.WkvXGbUxUTzNcHawKRRwrPehIxSXHVc70jFOp3yb8yZgjGUuET."
# note: the encoded password hash above is "nutanix/4u" (without the quotes)
#endregion