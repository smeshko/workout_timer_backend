# Build image
FROM swift:5.2.3-bionic as build

RUN apt-get update -y \
    && apt-get install -y libsqlite3-dev

WORKDIR /build

COPY . .

# RUN for f in Sources/App/Modules/*; do \
# m=$(basename $f); \
# cp -r "${f}/Views/" "Resources/Views/${m}" 2>/dev/null; \ done; \
# exit 0;

RUN swift build \ 
    --enable-test-discovery \ 
    -c release \
    -Xswiftc -g

# Run image
FROM swift:5.2.3-bionic-slim

RUN useradd --user-group --create-home --home-dir /app vapor

WORKDIR /app

COPY --from=build --chown=vapor:vapor /build/.build/release /app
COPY --from=build --chown=vapor:vapor /build/Public /app/Public

USER vapor
ENTRYPOINT ["./Run"]
CMD ["serve", "--env", "development", "--hostname", "0.0.0.0", "--port", "8080"]
 
