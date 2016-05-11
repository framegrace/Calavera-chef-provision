#!/bin/bash
pushd /opt/Calavera-chef-provision/
chef-client -z create-environment.rb
popd
