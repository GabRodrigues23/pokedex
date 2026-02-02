# 📡 API Reference --- Pokédex

This document describes the external API endpoints used by the Pokédex
application.\
The app consumes data from the public **PokeAPI**.

Base URL:\
https://pokeapi.co/api/v2

------------------------------------------------------------------------

## 🔹 Get Pokémon List

Returns a paginated list of Pokémon with basic information.

**Endpoint**

    GET /pokemon

**Query Parameters** \| Name \| Type \| Description \|
\|--------\|------\|-------------\| \| limit \| int \| Number of Pokémon
returned \| \| offset \| int \| Offset for pagination \|

**Example**

    GET https://pokeapi.co/api/v2/pokemon?limit=151&offset=0

**Response (simplified)**

``` json
{
  "results": [
    {
      "name": "bulbasaur",
      "url": "https://pokeapi.co/api/v2/pokemon/1/"
    }
  ]
}
```

------------------------------------------------------------------------

## 🔹 Get Pokémon Details

Returns detailed information about a specific Pokémon.

**Endpoint**

    GET /pokemon/{id}

**Path Parameters** \| Name \| Type \| Description \|
\|------\|------\|-------------\| \| id \| int \| Pokémon ID \|

**Example**

    GET https://pokeapi.co/api/v2/pokemon/1

**Response (simplified)**

``` json
{
  "id": 1,
  "name": "bulbasaur",
  "types": [
    {
      "slot": 1,
      "type": {
        "name": "grass"
      }
    }
  ]
}
```

------------------------------------------------------------------------

## 🎯 Data Used by the App

From the list endpoint: - `name` - `url` (used to extract Pokémon ID)

From the details endpoint: - `id` - `name` - `types[0].type.name` (main
type)

------------------------------------------------------------------------

## 🧠 Caching Strategy

The application caches Pokémon types locally using **SharedPreferences**
to improve performance.

Cached structure example:

``` json
{
  "1": "grass",
  "4": "fire",
  "7": "water"
}
```

------------------------------------------------------------------------

## ⚠️ Notes

-   The API is public and does not require authentication.
-   Rate limits may apply.
-   Pokémon types are considered stable and rarely change.

------------------------------------------------------------------------

## 🌐 Official Documentation

PokeAPI Docs:\
https://pokeapi.co/docs/v2
