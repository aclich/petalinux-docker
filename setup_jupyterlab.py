import os, subprocess
from notebook.auth import passwd
conf_file = os.path.join(subprocess.check_output("jupyter --config-dir", shell=True).decode().strip(),
                         'jupyter_lab_config.py')
open(conf_file, 'a').write(f'''
c.NotebookApp.ip='*'
c.NotebookApp.password=u'{passwd('')}'  
c.NotebookApp.open_browser = False
c.NotebookApp.port = 5000
c.NotebookApp.allow_root = True
''')