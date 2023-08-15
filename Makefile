format:
	dartfmt  --fix -w -l 120 .

get:
	flutter pub get

run\:web:
	flutter run -d web-server --web-renderer canvaskit 

run\:linux:
	flutter run -d linux

run\:web\:prod:
	python3 -m http.server --directory /app/build/web/ 3000

build\:dep:
	flutter packages pub run build_runner build --delete-conflicting-outputs

install:
	flutter pub get

build\:web:
	flutter build web --web-renderer canvaskit --release --no-sound-null-safety
	