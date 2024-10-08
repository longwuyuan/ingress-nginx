#!/bin/bash

# Copyright 2014 The Kubernetes Authors.
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

set -o errexit
set -o nounset
set -o pipefail

luacheck --codes --globals lua_ingress \
    --globals configuration \
    --globals balancer \
    --globals monitor \
    --globals certificate \
    --globals tcp_udp_configuration \
    --globals tcp_udp_balancer \
    --no-max-comment-line-length -q rootfs/etc/nginx/lua/

find rootfs/etc/nginx/lua/ -name "*.lua" -not -path "*/test/*" -exec lj-releng -L -s {} + && echo "lj-releng validation is success!"
