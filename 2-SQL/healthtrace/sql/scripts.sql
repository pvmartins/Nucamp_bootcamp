SELECT b.*, s.name as service_name
FROM billings b
JOIN services s ON b.service_id = s.id
where b.patient_id = 1002;


# # creates a one-to-many relationship between the Patients table and Appointments table
# appointments = db.relationship('Appointments', backref='patients', 
#                                cascade="all,delete", 
#                                foreign_keys='Appointments.patient_id')

# # creates a reverse relationship from the Appointments table to the Patients table
# patients = db.relationship('Patients', backref=db.backref('appointments', 
#                                                          cascade="all,delete"))

"""
Me: why we dont name the  relationship  "appointments_practitioners" ?
AI: You don't need to name the relationship as appointments_practitioners - you can use any name you'd like. 
However, it's important to ensure that the name is descriptive and accurately reflects the relationship between the two tables. 
Additionally, when setting up relationships between tables, it is important to use the foreign key field to link the two tables together.

Human: the reverse relationship goes in the many table right ?
AI: Yes, you are correct. The reverse relationship will go in the many table, as this is the table containing the foreign key which connects the two tables.


AI: Lazy=True indicates the type of query load to be used. Lazy loading enables queries to be executed only when they are needed, which helps improve performance. 
By default, SQLAlchemy uses "lazy='select'" which creates an additional select statement for each relationship. 
Other options include "lazy='joined'" which uses one join query to load all of the related rows in one query, and "lazy='subquery'" which loads the related rows in one subquery. 
You can find more information about lazy loading here: http://docs.sqlalchemy.org/en/latest/orm/loading_relationships.html#sqlalchemy.orm.configurable.LazySQLalchemy.orm.configurable.Lazy




"""

cd ~/Desktop/NucampFolder/Python

 2234  docker --version\n
 2236  docker run
 2237  docker run --rm hello-world\n
 2239  systemctl start docker
 2240  sudo dockerd
 2241  sudo service --status-all 
 2242  clear
 2243  sudo service --status-all
 2244  docker start
 2245  docker run --rm hello-world\n
 2246  brew services stop postgres\n
 2247  cd ~/Desktop/NucampFolder/Python
 2248  cd 2-SQL
 2249  docker compose ls\n
 2250  docker compose up -d\n
 2251  docker compose ls\n
 2252  docker exec pg_container psql -c 'SELECT COUNT(*) FROM pg_database'
 2253  docker compose ps\n
 2254  docker compose logs
 2255  docker exec -it pg_container psql\n
 2256  pyenv shell 3.9.9
 2270  cat workshop1.sql | docker exec -i pg_container psql
 2271  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2276  cat workshop1.sql | docker exec -i pg_container psql
 2287  cat healthtrace.sql | docker exec -i pg_container psql

 2309  . venv/bin/activate
 2310  python -m venv venv 
 2311  .venv/bin/activate
 2312  source venv/bin/activate
 2313  python -m venv venv
 2314  source venv/bin/activate
 2315  pip list
 2316  python -m pip install -r requirements.txt 
 2317  pip show alembic
 2318  docker compose up -d\n
 2319  pip show alembic\n
 2320  mkdir alembic\n
 2321  cd alembic\n
 2322  alembic init .\n
 2323  alembic revision -m "create customers"\n
 2324  alembic upgrade head\n
 2325  alembic downgrade base\n
 2326  alembic revision -m "add customers date_of_birth"
 2327  alembic upgrade head\n
 2328  alembic downgrade 459d1b32c308\n
 2329  alembic upgrade head\n
 2330  alembic history\n
 2331  alembic downgrade 0d9ccadb8cbf\n
 2332  alembic current\n
 2333  alembic upgrade 459d1b32c308
 2334  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2335  pip show psycopg2-binary\n
 2336  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2337  pip show psycopg2-binary\n
 2338  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2339  python -m pip install -r requirements.txt 
 2340  pip show psycopg2-binary\n
 2341  mkdir psycopg2\n
 2342  cd psycopg2\n
 2343  touch veggies.py\n
 2344  python veggies.py\n
 2345  cd ..
 2346  unzip -q flask.zip\n
 2347  rm flask.zip\n
 2348  pip show flask\n
 2349  docker exec -i pg_container psql -c 'CREATE DATABASE twitter;'\n
 2350  cd flask/twitter\n
 2351  flask db migrate\n
 2352  alembic --version\n
 2353  flask db migrate\n
 2354  flask --help
 2355  flask --version
 2356  python -m pip install -r requirements.txt 
 2357  cd ..
 2358  python -m pip install -r requirements.txt 
 2359  flask --version
 2360  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2361  flask --version
 2362  cd flask/twitter\n
 2363  flask db migrate\n
 2371  cd ..
 2372  pip show faker\n
 2373  python seed.py\n
 2374  mkdir twitter/src/api\n
 2375  cd twitter/src/api\n
 2376  touch users.py tweets.py\n
 2377  cd ../..\n
 2378  export FLASK_ENV=development\n
 2379  flask run\n
 2380  export FLASK_ENV=development\n
 2381  cd ../..\n
 2382  export FLASK_ENV=development\n
 2383  flask run\n
 2384  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2385  cd twitter/\n
 2386  cd Python/2-SQL/week3
 2387  ls
 2388  cd flask
 2389  cd twitter
 2390  export FLASK_ENV=development\n
 2391  flask run\n
 2392  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2393  docker exec -i pg_container psql -c 'CREATE DATABASE healthtrace2;'
 2394  ls
 2395  cd healthtrace
 2396  ls
 2397  flask db migrate
 2398  flask db upgrade\n
 2399  flask db migrate
 2400  flask db upgrade\n
 2401  flask db migrate
 2402  flask db upgrade\n
 2403  flask db migrate
 2404  cat healthtrace2.sql | docker exec -i pg_container psql
 2405  ls
 2406  cd src
 2407  ls
 2408  cat healthtrace2.sql | docker exec -i pg_container psql
 2409  cat healthtrace_2_seed.sql | docker exec -i pg_container psql
 2410  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2411  export FLASK_ENV=development
 2412  flask run\n
 2413  cd ..
 2414  export FLASK_ENV=development
 2415  flask run\n
 2416  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2417  export FLASK_ENV=development
 2418  flask run\n
 2419  ls
 2420  cd 2-SQL
 2421  ls
 2422  cd week3
 2423  ls
 2424  venv/bin/activate
 2425  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2426  export FLASK_ENV=development
 2427  flask run\n
 2428  cd flask
 2429  flask run\n
 2430  ls
 2431  cd twitter
 2432  ls
 2433  cd src
 2434  ls
 2435  flask run\n
 2436  export FLASK_ENV=development
 2437  cd ..
 2438  export FLASK_ENV=development
 2439  flask run\n
 2440  cd flask
 2441  flask run\n
 2442  conda activate base
 2443  flask show
 2444  flask help
 2445  pip show flask\n
 2446  python -m pip install -r requirements.txt 
 2447  cd ..
 2448  python -m pip install -r requirements.txt 
 2449  ls
 2450  source /Users/paulovmartins/Desktop/NucampFolder/Python/2-SQL/week3/.venv/bin/activate
 2451  export FLASK_ENV=development
 2452  flask run\n
 2453  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2454  export FLASK_ENV=development
 2455  flask run\n
 2456  cd flask
 2457  ls
 2458  flask run\n
 2459  cd twitter
 2460  flask run\n
 2461  docker exec pg_container pg_dump --verbose --file moma_dump.sql moma
 2462  docker exec pg_container ls\n
 2463  docker exec pg_container head -n 100 moma_dump.sql
 2464  docker cp pg_container:moma_dump.sql data\n
 2465  docker exec pg_container psql -c 'CREATE DATABASE moma_copy;'\n\n
 2466  docker exec pg_container psql moma_copy -f moma_dump.sql
 2467  docker exec -it pg_container psql\n
 2468  docker exec pg_container psql -c 'DROP DATABASE moma_copy;'\n
 2469  cd /opt/datadog-agent/etc/datadog.yaml
 2470  cd /opt/datadog-agent/etc/
 2471  ls
 2472  open .
 2473  launchctl
 2474  launchctl enable
 2475  datadog-agent
 2476  datadog-agent run
 2477  sudo lsof -i -n -P | grep TCP\n\n
 2478  datadog-agent run
 2479  postgres://my_postgress_db_user:xWHIzj97KSJogXppJa4TqrgsqhmPYo5r@dpg-cf1kdmp4reb5o42q72c0-a/my_postgress_db
 2480  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2481  flask db migrate
 2482  ls
 2483  cd ..
 2484  Flask run
 2485  export FLASK_ENV=development
 2486  Flask run
 2487  flask db migrate
 2488  flask db upgrade\n
 2489  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2490  export FLASK_ENV=development
 2491  Flask run
 2492  flask db downgrade '8665bb23411a'\n
 2493  flask db downgrade 26f154cb4fcd\n
 2494  flask db downgrade\n
 2495  Flask run
 2496  flask db downgrade 8665bb23411a\n
 2497  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2498  cat healthtrace_models.py | docker exec -i pg_container psql
 2499  source /Users/paulovmartins/Desktop/NucampFolder/Python/1-Fundamentals/.venv/bin/activate
 2500  cat healthtrace_models.py | docker exec -i pg_container psql
 2501  ls
 2502  cd src
 2503  ls
 2504  cat healthtrace_models.py | docker exec -i pg_container psql
 2505  Flask run
 2506  cd ..

 {
    "id": "12345",
    "first_name": "John",
    "last_name": "Doe",
    "date_of_birth": "10/01/1990",
    "sex_at_birth": "M",
    "phone": "123-456-7890",
    "email": "example@example.com",
    "home_address": "123 Main Street, Anytown, US 12345",
    "occupation": "Software Engineer",
    "preferred_pharmacy": "Walmart Pharmacy",
    "blood_type": "O+",
    "created_at": "01/01/2021"
},{
    "id": "12346",
    "first_name": "Jane",
    "last_name": "Smith",
    "date_of_birth": "10/25/1992",
    "sex_at_birth": "F",
    "phone": "098-765-4321",
    "email": "example2@example.com",
    "home_address": "456 Apple Street, Anytown, US 12345",
    "occupation": "Accountant",
    "preferred_pharmacy": "Walgreens Pharmacy",
    "blood_type": "A-",
    "created_at": "05/01/2021"
}