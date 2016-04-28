#!/bin/bash
pushd /opt/Calavera-chef-provision/
chef-client -z start-environment.rb
popd
