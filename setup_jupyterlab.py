import os, subprocess
from notebook.auth import passwd
conf_file = os.path.join(subprocess.check_output("jupyter --config-dir", shell=True).decode().strip(),
                         'jupyter_lab_config.py')
open(conf_file, 'a').write(f'''
c.ServerApp.ip='*'
# c.ServerApp.password=u'{passwd('')}'
c.ServerApp.open_browser = False
c.ServerApp.port = 5000
c.ServerApp.allow_root = True
''')