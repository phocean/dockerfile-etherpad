#!/bin/bash

chown -R etherpad:etherpad /opt/etherpad-lite/var
su etherpad -s /bin/bash -c  "dumb-init node /opt/etherpad-lite/node_modules/ep_etherpad-lite/node/server.js"
