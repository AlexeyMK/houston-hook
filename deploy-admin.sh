USAGE="Usage: deploy_admin.sh YOURAPP_URL DESIRED_ADMIN_URL (IE deploy_admin.sh frogs.meteor.com frogs-admin.meteor.com)"

if [ ! $1 ] ; then
  echo $USAGE
  exit 1
fi

# remove potential trailing slash
PRODAPP_URL=${1%/}
PRODAPP_HOOK_URL=$PRODAPP_URL/_houston_hook

# 1. figure out admin url
ADMIN_URL=$2 # TODO OPTIONAL TOO

# 2. grab mongo_url string
echo trying to grab mongo_url from $PRODAPP_HOOK_URL
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
touch $TMP_SETTINGS_JSON
echo {\"app_mongourl\": \"$MONGO_URL\"} > $TMP_SETTINGS_JSON

#4. deploy admin app (we have a re-built app for this already in houston-hook)
PREBUILT_APP=`dirname $0`/prebuilt_app
cd $PREBUILT_APP
echo "Set password for protecting the deployment at $2"
meteor deploy $ADMIN_URL --settings $TMP_SETTINGS_JSON --password

#5. remove leftovers
cd -
rm $TMP_SETTINGS_JSON
