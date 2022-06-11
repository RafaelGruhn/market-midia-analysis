#!/bin/bash
set -e
set -x

if [ "$MODE" = "development" ]; then
    echo "Creating migrations..."
    python manage.py makemigrations
    echo "Created!"
fi

echo "Migrating models..."
python manage.py migrate
echo "Migrated!"

echo "Loading fixtures (uncomment if you want to load)..."
#python manage.py loaddata */fixtures/*.json
echo "Loaded!"


#echo "Compiling translations..."
#python manage.py compilemessages -v 0
#echo "Done!"

if [ "$MODE" = "production" ]; then
    echo "Coping default media..."
    mkdir -p /var/www/core_proj/media/
    cp -a /code/core_proj/media/. /var/www/core_proj/media/
    echo "Done"

    echo "Collecting statics..."
    python manage.py collectstatic --noinput -v 0
    echo "Collected"

    echo "Compressing..."
    python manage.py compress
    echo "Done"

    echo "Starting core_proj as `whoami`" &
    exec gunicorn core_proj.wsgi:application --name core_proj \
        --timeout 300 \
        --workers $NUM_GUNICORN_WORKERS --bind 0.0.0.0:$DJANGO_PORT --log-level=info \
        --log-file=$LOGS_ROOT/gunicorn_log.log --access-logfile=$LOGS_ROOT/gunicorn_access.log

elif [ "$MODE" = "development" ]; then
    echo "Starting core_proj as `whoami`"
    python manage.py runserver 0.0.0.0:8000
fi
