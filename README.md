# Local Fresh Deliveries

## About

This project explores some features of Streamlit & Flask to build a comprehensive web app simulating a local, fresh food delivery service.

This project was born from the realization that, while there are many grocery delivery services, there are few that cater towards those that desire food delivered directly from local farms and fish markets. Intended users consist of restaurants and private chefs in need of last minute groceries that cannot be bought with quality standards in mind from commercial grocery stores such as Walmart or Vons. The app connects local farms and fish markets with delivery drivers, who pick up local produce and deliver it to customers. For a customer, they can view what produce is available at which stores, and can order what they want. A driver will then pick up their order and deliver it to their doorstep.

## Team
Frank Glantz \
Jahan Goel \
Jaiman Bharadwa \
Raghav Mathur \
Ellison Lin

## Startup
1. Go to the terminal and run the command 'docker compose up -d' to create containers for the api, app and database.

2. Create a .env file in the api folder with the following information: \
SECRET_KEY=someCrazyS3cR3T!Key.! \
DB_USER=root \
DB_HOST=db \
DB_PORT=3306 \
DB_NAME=localfresh \
MYSQL_ROOT_PASSWORD=[password here]

3. Run the Docker containers and go to 'localhost:8501'

## Video Overview

https://www.youtube.com/watch?v=1zpEw-VgLPw
