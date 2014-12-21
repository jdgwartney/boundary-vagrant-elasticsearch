boundary-vagrant-elasticsearch
==============================



Configuration
-------------



Boundary Agent
--------------

To have puppet install the agent automatically the `manifest/site.pp` with the API Token:

   ```
   class { 'boundary':
     token => '<api token>'
   }
   ```

NOTE: Current performing a work around to install the Boundary Meter Puppet module by pulling it directly from GitHub since the Boundary Meter Puppet module has not been updated on Puppet Forge as 2014-12-21
