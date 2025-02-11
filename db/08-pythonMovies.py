import pg8000.native
import os
from dotenv import load_dotenv

load_dotenv()

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME")

conn = pg8000.native.Connection(user=DB_USER, database=DB_NAME,
                                password=DB_PASSWORD)

def select_movies(sort_by=None, order="ASC",min_rating=None,location=None):
    order_by = "ORDER BY title"
    rating_check = ""

    if min_rating:
        rating_check = f"WHERE rating >{min_rating}"

    if sort_by == 'release_date':
        order_by = "ORDER BY release_date"

    elif sort_by == 'rating':
        order_by = "ORDER BY rating"

    elif sort_by == 'cost':
        order_by = "ORDER BY cost"

    main_query = "SELECT * FROM movies"

    results = conn.run(f"{main_query} {rating_check} {order_by} {order}")
    columns = [el['name'] for el in conn.columns]
    movies_list = [dict(zip(columns, row)) for row in results]
    print(movies_list)

select_movies(sort_by ='rating', min_rating= 8)

conn.close()