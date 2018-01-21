# Counties

```
state="${1}"

curl -s https://en.wikipedia.org/wiki/List_of_counties_in_$state | grep -iE "^<li>" | grep -i "_County" | grep -o "title=.*\"" | grep -o "\".*, " | tr -d ',"' | sed 's/ County//g'
```
