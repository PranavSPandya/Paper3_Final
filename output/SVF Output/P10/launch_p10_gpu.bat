@echo off
set PATH=C:\Users\pandya\Documents\Github\docker\Paper3_Final\temp\tf_dml_venv\Lib\site-packages\tensorflow-plugins\directml;C:\Users\pandya\Documents\Github\docker\Paper3_Final\temp\tf_dml_venv\Lib\site-packages\tensorflow-plugins;%PATH%
set DML_VISIBLE_DEVICES=0
set TF_CPP_MIN_LOG_LEVEL=0
set TF_ENABLE_ONEDNN_OPTS=0
cd /d "C:\Users\pandya\Documents\Github\docker\Paper3_Final\scripts\SVF Computation"
"C:\Users\pandya\Documents\Github\docker\Paper3_Final\temp\tf_dml_venv\Scripts\python.exe" "C:\Users\pandya\Documents\Github\docker\Paper3_Final\scripts\SVF Computation\compute_svf_camup.py" --participant P10 --phase all --batch-size 7 > "C:\Users\pandya\Documents\Github\docker\Paper3_Final\output\SVF Output\P10\P10_CamUp_GPU_DirectML.log" 2> "C:\Users\pandya\Documents\Github\docker\Paper3_Final\output\SVF Output\P10\P10_CamUp_GPU_DirectML.err"
