VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.6.3"

$vb_memory = 1024
$vb_cpus = 1

# See https://vagrantcloud.com/yungsang/boxes/boot2docker
# See http://blog.zenika.com/index.php?post/2014/10/07/Setting-up-a-development-environment-using-Docker-and-Vagrant

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "boot2docker"
  config.vm.box = "yungsang/boot2docker"

  config.vm.provider :virtualbox do |vb|
    vb.memory = $vb_memory
    vb.cpus = $vb_cpus
  end

  config.vm.synced_folder ".", "/app"

  # Or you can use NFS as before
  # config.vm.network "private_network", ip: "192.168.33.10"
  # config.vm.synced_folder ".", "/app", type: "nfs"

  # Uncomment below to use more than one instance at once
  #config.vm.network :forwarded_port, guest: 2375, host: 2375, auto_correct: true

  # Fix busybox/udhcpc issue
  config.vm.provision :shell do |s|
    s.inline = <<-EOT
      if ! grep -qs ^nameserver /etc/resolv.conf; then
        sudo /sbin/udhcpc
      fi
      cat /etc/resolv.conf
    EOT
  end

  # Adjust datetime after suspend and resume
  config.vm.provision :shell do |s|
    s.inline = <<-EOT
      sudo /usr/local/bin/ntpclient -s -h pool.ntp.org
      date
    EOT
  end

  # config.vm.provision :docker do |d|
  #  d.pull_images "yungsang/busybox"
  #  d.run "simple-echo",
  #    image: "yungsang/busybox",
  #    args: "-p 8080:8080",
  #    cmd: "nc -p 8080 -l -l -e echo hello world!"
  # end
      
  # [ngircd] Port Forwarding (only SSL)
  config.vm.network "forwarded_port", guest: 6697, host: 6697

  # [kiwiirc] Port Forwarding (only SSL)
  config.vm.network "forwarded_port", guest: 7778, host: 7778

  # [rails][telescope] Port Forwarding
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  # [phppgadmin][kanboard] Port Forwarding
  config.vm.network "forwarded_port", guest: 80, host: 3001

end
