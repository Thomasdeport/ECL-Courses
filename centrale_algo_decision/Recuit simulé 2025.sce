clear // Efface les données

// Réglages recuit simulé
Temp=25; // Température initiale puis courante (décroit au cours de l'algorithme)
TempGel=1.00; // Température de gel (fixe); constitue un critère d'arrêt
// On adopte ici une loi de décroissance géométrique T(i+1)=alpha*T(i)
alpha=0.95; // Taux de décroissance 
// Possibilité de changer la loi de décroissance à la fonction "palier" défini plus bas
kEquil=10; // Nombre d'itération sur un palier de température

//******************************************************************************
// Problème Voyageur de commerce; DEFINITION DES VILLES et paramétrages
// Nbr de villes
N=50;
// Graine de la série pseudo aléatoire (permet de fixer les villes tirées au "hasard")
rand("seed",11);

// choix typologie des villes **************************************************
// disposées sur un cercle si Cercle=%t sinon aléatoire sur un carré Cercle=%f
Cercle=%f; 
if Cercle then
    rad=rand(N,1)*2*%pi;
    xpos=cos(rad);
    ypos=sin(rad);
else
    //coord. x et y des positions des villes sur un carre -1,1
    xpos=2*rand(N,1)-1; //if xpos>0 then xpos=xpos./2+0.5 else xpos=xpos.*rand(N,1)end
    ypos=2*rand(N,1)-1; //if ypos>0 then ypos=ypos.^3 else ypos=ypos end
    // indicateur=xpos.*ypos;
    // for j=1:N do if indicateur(j)<0 then xpos(j)=-xpos(j)else xpos(j)=xpos(j)^3 end end;
   // if  <0 then xpos=-xpos; end
    end

// calcul préliminaire des distances euclidiennes entre ville : tableau NxN
dx2=((xpos*ones(1,N))-(xpos*ones(1,N))').^2; 
dy2=((ypos*ones(1,N))-(ypos*ones(1,N))').^2; 
distance=sqrt(dx2+dy2);

// Les villes et le tableau des distances étant définis, 
// on réinitialise le générateur pseudo aléatoire sur une valeur n°cas;
// si on écrit rand("seed") seul, valeur choisie par le PC sur horloge   
cas=4;rand("seed",cas); 
// attention les figures 1, 2 et 3 sont réservées; choisir cas>3

//******************************************************************************


// fonction COUT : *************************************************************
// arguments d=distance; c=cycle; n=nombre de villes ; sortie Z
// calcul la distance totale du cycle
function [Z] = Eval(d,c,n)
Z=0;
for kc=1:n-1
Z=Z+d(c(kc),c(kc+1)); 
end;
Z=Z+d(c(N),c(1));
endfunction

// fonction PERMUTATION cycle voisin *******************************************
// Cette fonction définit le voisinage
// type mutation 2-opt
function [cycleV]=Voisin(c,n)
    Ip=floor(1+n*rand());
    Jp=floor(1+n*rand());
    mx=max(Ip,Jp);
    mn=min(Ip,Jp);
    // modif voisinage
    testV=rand();
    if testV<0 then Jp=Ip+1
    end
    // fin modif
    cc=c;
    cc(mn:mx)=flipdim(cc(mn:mx),1);
    cycleV=cc;
endfunction

// fonction d'ACCEPTATION ******************************************************
// règle Métropolis (distribution de Boltzmann)
// retourne vrai ou faux
function [V]=Prendre(cout,coutcourant,T)
    DeltaCout = cout-coutcourant;
    p=rand();
    V=%f;
    if (DeltaCout>0)then if (p<exp(-DeltaCout/T)) then V=%t; end end
    if DeltaCout<0 then V=%t; end 
endfunction

// fonction DECROISSANCE DE LA TEMPERATURE *************************************
// peut être modifiée moyennant de nouvelles entrées
function [T] = palier(Tc,aT)
T=Tc*aT; // Loi géométrique simple  
endfunction

// fonction GRAPHE d'un cycle **************************************************
// Le graphe est tracé dans la figure identifié pas le choix du n°cas
// Permet d'avoir plusieurs solutions avec des graines différentes
function plotGraf(cycle)
    f=scf(cas);clf(cas);
    graf=[cycle;cycle(1)]
    isoview on
    plot(xpos(graf),ypos(graf));
    plot(xpos(graf),ypos(graf),'o');
    xtitle('Chemin le meilleur obtenu :  '+string(CoutMeilleur));
endfunction

// Fin des fonctions ***********************************************************

//******************************************************************************
//Cycle aléatoire de DEPART (villes classées de 1 à N)
// La séquence des villes dépend du tirage initial
Cycle = linspace(1,N,N)';
// Evaluation de la performance initiale *********
CoutCourant = Eval(distance,Cycle,N);
CoutMeilleur=CoutCourant;
CycleMeilleur=Cycle;
plotGraf(CycleMeilleur)
//******************************************************************************

// ALGORITHME DU RECUIT SIMULE proprement dit **********************************

tic(); // pour mesurer le temps de calcul (départ chrono)
ci=1;cp=1;
while Temp>TempGel
    drap=0;
    for g=1:kEquil // Boucle sur l'équilibre
        Candidat=Voisin(Cycle,N)
        CoutCandidat=Eval(distance,Candidat,N)
        if Prendre(CoutCandidat,CoutCourant,Temp) then
            Cycle=Candidat;
            CoutCourant=CoutCandidat;
            drap=drap+1;
            end
            if CoutCourant<CoutMeilleur then 
                CoutMeilleur=CoutCourant;
                CycleMeilleur=Cycle;
                plotGraf(CycleMeilleur)
            end
    Tabcout(ci)=CoutCourant; 
    Tabtemp(ci)=Temp; 
    ci=ci+1;         
    end
    Tabaccep(cp)=drap/kEquil;
    cp=cp+1;
    Temp=palier(Temp,alpha);
    end

temps_calcul=toc(); // pour mesurer le temps de calcul (fin chrono, temps de calcul)

// FIN RECUIT SIMULE ***********************************************************


// TRACE de l'évolution de l'acceptation ***************************************
// Figure n°3 
f=scf(3);
plot(Tabaccep);
xtitle('Evolution du taux d''acceptation','PALIERS','TAUX')
// *****************************************************************************

// TRACE de l'évolution de la decroissance température *************************
// Figure n°2
f=scf(2);
plot(Tabtemp);
xtitle('Evolution de la température','ITERATIONS','TEMPERATURE')
// *****************************************************************************

// TRACE de l'évolution de la fonction cout en fonction des itérations *********
// Figure n°1
f=scf(1);
plot(Tabcout);
xtitle('Evolution de la fonction coût; final : '+string(CoutMeilleur),'ITERATIONS','COÛT')
// *****************************************************************************

disp("Temps de Calcul = ",temps_calcul);
disp("Distance optimisée la meilleure obtenue = ", CoutMeilleur);




