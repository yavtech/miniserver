use std::{env, sync::Arc};

use actix_files as fs;
use actix_web::{App, HttpServer};

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let mut args = env::args();
    args.next();
    let path = if let Some(path) = args.next() {
        path
    } else {
        "/wwwroot".to_owned()
    };

    println!("Serving files at: {path}");
    let path = Arc::new(path);
    HttpServer::new(move || {
        App::new().service(fs::Files::new("/", path.as_str()).index_file("index.html"))
    })
    .bind(("0.0.0.0", 8000))?
    .run()
    .await
}
