# Finiam Secrets

*Send your secret sauce recipe safely.*

Finiam Secrets is a simple web app that transmits E2E encrypted messages safely.

The way it works is by encrypting the user info locally and then generating a URL with a private key embbeded on it, through the `hash` in the URL, which is never sent to servers by browsers or any HTTP client. When you generate a secret, the webapp posts the encrypted information to our API, which in turn stores that encrypted information and assigns it an ID that we like to call `roomId`.

The webapp then builds the link so you can copy it and share it.

```
https://secrets.finiam.com/<roomId>#<encryptionKey>
```

## Encryption

All encryption is done on the frontend using the [crypto](https://developer.mozilla.org/en-US/docs/Web/API/Crypto) web API. With that API we generate `AES-GCM` encryption and decryption keys derived from a password based key (`PBKDF2`).

The decryption key is stored in the URL through the hash. The hash is the part that comes after `#` and it's never sent to servers, so we can never ever see what you are sharing on the service.

When you share the secret with someone, you still are exposing the decryption key. However, the information itself is never available to these services, unless, they somehow are able to extract all that info from our URL. Our API immediatly deletes any encrypted secret after it's access, so if you are able to read the secret, it means nobody else will be able to in the future, nor did it was read in the past.

All randomly generated numbers on the frontend and backend are 100% crypto secure and generated only using crypto secure modules by using the native `crypto.getRandomValues` on the frontend (Javascript) and `:crypto.strong_rand_bytes` on the backend (Elixir/Erlang).

Also, all secrets expire after 1 hour.

## Setup guide

To setup this repo you need to have a couple of things:
- `erlang` - we recommend `asdf-vm` to manage node versions
- `elixir` - we recommend `asdf-vm` to manage node versions
- `node` - we recommend `asdf-vm` to manage node versions
- `redis`

You can run our `setup` script to setup the correct node version, if you have `asdf-vm`:
```bash
bin/setup
```

Now everything is ready and you can run your dev server and visit the website at `localhost:3000`:
```bash
bin/server
```

## Available Scripts

### bin/setup

Provided you have ASDF, this script will set node versions.

### bin/server

Runs the development server

### bin/lint

Lints all code.

### bin/build

Builds the static site and outputs it on `out`.
