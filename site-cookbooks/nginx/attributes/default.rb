#
# Cookbook Name:: nginx
# Attributes:: default
#
# Author:: Adam Jacob (<adam@opscode.com>)
# Author:: Joshua Timberman (<joshua@opscode.com>)
#
# Copyright 2009-2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default[:nginx][:version]      = "0.8.54"

case platform
when "debian","ubuntu"
  default[:nginx][:dir]        = "/etc/nginx"
  default[:nginx][:root_dir]    = "/var/www"
  default[:nginx][:log_dir]    = "/var/log"
  default[:nginx][:user]       = "www"
  default[:nginx][:binary]     = "/usr/sbin/nginx"
  default[:nginx][:init_style] = "runit"
  default[:nginx][:cache_expire] = "1m"
else
  default[:nginx][:dir]        = "/etc/nginx"
  default[:nginx][:root_dir]    = "/var/www"
  default[:nginx][:log_dir]    = "/var/log"
  default[:nginx][:user]       = "www"
  default[:nginx][:binary]     = "/usr/sbin/nginx"
  default[:nginx][:init_style] = "init"
  default[:nginx][:cache_expire] = "1m"
end

default[:nginx][:gzip] = "on"
default[:nginx][:gzip_http_version] = "1.0"
default[:nginx][:gzip_comp_level] = "2"
default[:nginx][:gzip_proxied] = "any"
default[:nginx][:gzip_types] = [
  "text/plain",
  "text/html",
  "text/css",
  "text/javascript",
  "text/xml",
  "application/x-javascript",
  "application/xml",
  "application/xml+rss",
  "application/javascript"
]
default[:nginx][:gzip_disables] = [
  "MSIE [1-6]\.",
  "Mozilla/4"
]

default[:nginx][:keepalive]          = "on"
default[:nginx][:keepalive_timeout]  = 65
default[:nginx][:worker_processes]   = cpu[:total]
default[:nginx][:worker_connections] = 2048
default[:nginx][:server_names_hash_bucket_size] = 64

default[:nginx][:disable_access_log] = false

default[:nginx][:sock] = "/var/www/sample-app/staging/shared/tmp/puma.sock"
#default[:nginx][:sock] = "/var/tmp/sample-app.sock"

default[:nginx][:server] = "192.168.33.11"
#default[:nginx][:server] = "www.denish.tech"

default[:nginx][:port] = 80
default[:nginx][:app] = "sample-app"
default[:nginx][:client_max_body_size] = "100m"
