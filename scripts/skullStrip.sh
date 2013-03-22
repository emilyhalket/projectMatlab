#! /bin/bash

cd /home/esievers/projectMatlab/subjects/${1}/structural/

echo "skull stripping ${1} ..."

/usr/local/fsl/bin/bet ${1}_mprage ${1}_mprage_brain -f .45 -o -m -R

cp ${1}_mprage_brain.nii.gz ${1}_mprage_brain_ac.nii.gz
cp ${1}_mprage_brain_mask.nii.gz ${1}_mprage_brain_mask_ac.nii.gz
cp ${1}_mprage_brain_overlay.nii.gz ${1}_mprage_brain_overlay_ac.nii.gz


gunzip ${1}*.nii.gz
