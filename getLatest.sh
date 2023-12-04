# This script will get the latest version of the bylaws from the city of toronto's website

mkdir pdfs

for i in $(seq -w 1 999);do
    curl -L -f http://www.toronto.ca/legdocs/municode/1184_$i.pdf --output pdfs/$i.pdf
done

curl -L -f http://www.toronto.ca/legdocs/municode/toronto-code-740.pdf --output pdfs/740.pdf

./convert.sh pdfs bylaw-txt 