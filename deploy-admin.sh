USAGE="Usage: deploy_admin.sh YOURAPP_URL DESIRED_ADMIN_URL [PASSWORD] (IE deploy_admin.sh frogs.meteor.com frogs-admin.meteor.com)"

if [ ! $1 ] ; then
  echo $USAGE
  exit 1
fi

# remove potential trailing slash
PRODAPP_URL=${1%/}
PRODAPP_HOOK_URL=$PRODAPP_URL/_houston_hook

PASSWORD=$3
if [ $3 ] ; then
  # not super secure, but it works
  PASSWORD=`date | md5`
  cat "For future changes, your deploy password is $PASSWORD"
fi

# 1. figure out admin url
ADMIN_URL=$2 # TODO OPTIONAL TOO

# 2. grab mongo_url string
cat trying to grab mongo_url from $PRODAPP_HOOK_URL
MONGO_URL=`curl $PRODAPP_HOOK_URL`

if [ ${MONGO_URL:0:7} != mongodb ]
then
  echo "Could not find mongo_url, instead found:"
  echo $MONGO_URL
  echo "Check your APP url and make sure houston hook is installed."
  exit 1
fi

#3. create settings.json
TMP_SETTINGS_JSON=/tmp/houstonhook_settings.json
cat {app_mongourl="$MONGO_URL"} > $TMP_SETTINGS_JSON

#4. deploy admin app (we have a re-built app for this already in houston-hook)
PREBUILT_APP=`dirname $0`/prebuilt_app
cd $PREBUILT_APP
meteor deploy ADMIN_URL --settings $TMP_SETTINGS_JSON --password $PASSWORD

#5. remove leftovers
cd -
rm TMP_SETTINGS_JSON
