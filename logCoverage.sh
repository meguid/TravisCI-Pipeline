rm -r Build
xcrun xccov view Build/Logs/Test/*.xcresult/3_Test/action.xccovreport --json > coverage.json
package=`ls Build/Logs/Test/*.xcresult`
coverage=`swift Parser.swift coverage.json`
echo $coverage
if [ $coverage -lt 80 ];
then
exit 1
else
exit 0
fi
