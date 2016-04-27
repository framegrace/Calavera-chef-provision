#!/bin/bash
# Test de integración. Muy sencillo, por ahora.
echo "Test de integración"
curl --silent "http://localhost:8080/MainServlet" | grep "This is a skeleton application"
RESULTAT=$?
[ $RESULTAT -eq 0 ] && echo "TODO BIEN" || echo "ALGO HA FALLADO"
exit $RESULTAT
