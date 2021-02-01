function newVal = delay(vector,n, i)
%applique un delay de n �chantillons
%pour �viter de changer la teille du vecteur � chaque �chantillon, on
%"simule" le temps r�el en pr�cisant l'indice i du temps courant
%retourne 0 si n>i
if (i-n)<1
    newVal=0;
else
    newVal=vector(i-n);
end
end

