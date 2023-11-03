## Home 家具電商 app - FLutter & Node.js & MongoDB

### Screenshots

|             Product Page             |              Cart Page               |
| :----------------------------------: | :----------------------------------: |
| <img src="mobile01.png" width="300"> | <img src="mobile05.png" width="300"> |

|              Login Page              |            Register Page             |              User Page               |
| :----------------------------------: | :----------------------------------: | :----------------------------------: |
| <img src="mobile02.png" width="300"> | <img src="mobile03.png" width="300"> | <img src="mobile04.png" width="300"> |

### Project Structure

#### Root

- `README.md`: This project documentation.
- `home/`: Flutter App frontend code.
- `home_api/`: Node.js API backend code.

#### `home/lib` Frontend Code

- `models/`: data class model.
- `providers/`: login, register api request.
- `screens/`: App screens.
- `services`: app theme, language localization, api route, shared preference setting.
- `widgets/`: App widgets.
- `main.dart`: Entry point of the Flutter app.

#### home_api/ Backend Code

- `db/conn.mjs`: MongoDB connection setting.
- `routes/`: API calling routes setting.
- `index.mjs`: Main entry point for the API.

### LICENCE

[WTFPL](http://www.wtfpl.net/about/)
