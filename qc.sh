
#push cod to remote repo
echo "adding file..."
git add .
echo -n "ok!, please input comments:"
read remarks
if [ ! -n "$remarks" ];then
    remarks="常规提交"
fi
git commit -m "$remarks"
echo "pushing code to remote repo..."
git push origin master
echo "ok!"
