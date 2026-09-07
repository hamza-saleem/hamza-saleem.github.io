build:
	flutter build web --release --web-renderer html --base-href /

serve:
	cd build/web && python3 -m http.server 8080

clean:
	flutter clean && flutter pub get
