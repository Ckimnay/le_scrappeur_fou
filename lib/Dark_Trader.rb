require 'nokogiri'
require 'open-uri'

def page_lien
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")) # ça ouvre la page et enregistre une variable 
    return page 
end 
#CREER TABLEAUX DES NOMS 
def get_data
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")) # ça ouvre la page web coinmarket et enregistre dans la variable page 
    noko_o = page.xpath("//tbody/tr/td/a[@class='currency-name-container link-secondary']") # dans la variable page j'ai extrait toutes les noms des currencies de la variable page et je les ai enregistré dans la variable noko_o  
    currencies = noko_o.map {|n| n.text} # j'ai fais une boucle à partir des élements de noko_o , et j'enregistre toutes ces valeurs dans l'array currencies en string car j'utlise .text
    return currencies # je récupère toutes les monnaies 
end 


#CREER UN TABLEAU DES PRIX 
def get_all_price
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))  # ça ouvre la page web coinmarket et enregistre dans la variable page 
    noko_o = page.xpath("//tbody/tr/td/a[@class='price']") #je prends la page web coinmarket de la variable page et je lui extrait les prix  de chaque currencies et je les stock dans la variable noko_o
    currencies_price = noko_o.map { |n| n.text.delete_prefix('$').to_f} # c'est un array qui contient la variable noko_o dont on a extrait les prix , dont on retire le symbole $  
    puts currencies_price # affiche mon tableau currencies sans le symbole $ 
	return currencies_price #je récupère tous les prix des monnaies 
end


#CREER UN TABLEAU DE FUSION DES NOMS ET DES PRIX 
def currencies_name_and_price
    currencies_price = get_all_price
    currencies = get_data
    both = Hash[currencies.zip currencies_price]
    #
    puts both 
end


def perform  #le role de perform est d'appeler les autres fonctions
	get_data
    get_all_price
    currencies_name_and_price
end

perform     #on apelle directement qu'une seule fonction perform