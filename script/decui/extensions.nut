elements <- [
    GUIButton, GUICanvas , GUICheckbox , GUIEditbox, GUILabel, GUIListbox ,
    GUIMemobox ,GUIProgressBar ,GUIScrollbar, GUISprite, GUIWindow
    ];

    function attachProps(props) {
        foreach(p,prop in props ) { 
            foreach(i,e in elements ) { 
                if (prop == "data" || prop == "elementData" || prop=="metadata") {
                     e[prop] <- { };
                } else if (prop == "parents" || prop == "childLists") {
                     e[prop] <- [];
                }  else if (prop == "autoResize" || prop == "delayWrap") {
                     e[prop] <- false;
                } else {
                    e[prop] <- null;
                }
            }
        }
    }
 
attachProps([ "UI","wrapOptions", "file","remove","autoResize", "RelativeSize", "ignoreGameResizeAutoAdjust"
    "id", "presets", "presetsList" "onClick", "onFocus", "onBlur", "onHoverOver","fadeOutTimer", "wrap", "delayWrap"
    "onHoverOut", "onRelease", "onDrag", "onCheckboxToggle", "onWindowClose", "align", "fadeInTimer", "fadeHigh"
    "onInputReturn", "onOptionSelect", "onScroll", "onWindowResize", "flags", "fadeStep", "fadeLow", "elementData"
    "onGameResize", "addPreset", "removePreset", "add", "parents"," children", "hidden", "context", "childLists",
    "contextMenu", "move", "parentSize", "tooltip", "tooltipVisible", "options",  "postConstruct", "preDestroy", "data", "metadata"
       ]);
 
//attach new functions
foreach(i,e in elements ) { 
     
     //removeBorders()
    e.rawnewmember("removeBorders", function() {
        local t = typeof this;
        local ui = this.UI;
        if (t == "GUICanvas" || t == "GUISprite"){
           ui.removeBorders(this);
        }
       
    }, null, false);

      //updateBorders()
    e.rawnewmember("updateBorders", function() {
        local t = typeof this;
        local ui = this.UI;
        if (t == "GUICanvas" || t == "GUISprite"){
           ui.updateBorders(this);
        }
       
    }, null, false);


    //addLeftBorder(borderObj)
    e.rawnewmember("addBorders", function(b= {}) {

       this.addLeftBorder(b);
       this.addRightBorder(b);
       this.addTopBorder(b);
       this.addBottomBorder(b);
       
    }, null, false);

      //isBorder()
    e.rawnewmember("isBorder", function() {

        return this.rawin("data") && this.data.rawin("isBorder") && this.data.isBorder;
       
    }, null, false);

    //addLeftBorder(borderObj)
    e.rawnewmember("addLeftBorder", function(b= {}) {
        local t = typeof this;
        local ui = this.UI;
        if (t == "GUICanvas" || t == "GUISprite"){
           ui.addBorder(this, b, "top_left");
        }
       
    }, null, false);

    //setBorderColor(border,colour)
    e.rawnewmember("setBorderColor", function(border, colour) {
        local t = typeof this;
        local ui = this.UI;
        if (t == "GUICanvas" || t == "GUISprite"){
            if (this.rawin("data") && this.data != null){
                
                if (this.data.rawin("borderIDs") && this.data.borderIDs != null){ 
                    foreach (idx, borderPos in this.data.borderIDs) {
                       
                        local b = ui.Canvas(borderPos);
                        if (b != null && b.data.borderPos == border){
                            b.Colour = colour;  
                            break;
                        }
                    } 
                }
            }
        }
       
    }, null, false);

     //setBorderSize(border,size)
    e.rawnewmember("setBorderSize", function(border, size) {
        local t = typeof this;
        local ui = this.UI;
        if (t == "GUICanvas" || t == "GUISprite"){
            if (this.rawin("data") && this.data != null){
                if (this.data.rawin("borderIDs") && this.data.borderIDs != null){
                    foreach (idx, borderPos in this.data.borderIDs) {
                        local b = ui.Canvas(borderPos);
                        if (b != null && b.data.borderPos == border){
                            b.size = size;
                            break;
                        }
                    }
                }
            }
        }
        
    }, null, false);

     //addRightBorder(borderObj)
    e.rawnewmember("addRightBorder", function(b= {}) {
        local t = typeof this;
        local ui = this.UI;
        if (t == "GUICanvas" || t == "GUISprite"){
         
           ui.addBorder(this, b, "top_right");
        }
       
    }, null, false);

     //addTopBorder(borderObj)
    e.rawnewmember("addTopBorder", function(b= {}) {
        local t = typeof this;
        local ui = this.UI;
        if (t == "GUICanvas" || t == "GUISprite"){
           ui.addBorder(this, b, "top_center");
        }
       
    }, null, false);

      //resetMoves()
    e.rawnewmember("resetMoves", function(b= {}) {
       if (this.metadata.rawin("movedPos")){
           this.metadata.movedPos.clear();
       }
       
    }, null, false);

     //addBottomBorder(borderObj)
    e.rawnewmember("addBottomBorder", function(b= {}) {
        local t = typeof this;
        local ui = this.UI;
      
        if (t == "GUICanvas" || t == "GUISprite"){
           ui.addBorder(this, b, "bottom_left");
        }
       
    }, null, false);

      //resize()
    e.rawnewmember("resize", function() {
        local t = typeof this;
        local ui = this.UI;  
      
        if (t == "GUICanvas" || t == "GUIWindow"){
            
                 local maxY = 0;
                local maxX = 0;
                foreach (i, c in this.getChildren()) {
                    if (!c.rawin("className")) {
                        if (this.autoResize && !c.isBorder()){
                            local x = c.Position.X + c.Size.X;
                            local y = c.Position.Y + c.Size.Y;

                            if (maxX < x){
                                maxX = x;
                            }
                            if (maxY < y){
                                maxY = y;
                            }

                            if (this.Size.Y < maxY){
                                this.Size.Y = maxY;
                            }
                            if (this.Size.X < maxX){
                                this.Size.X = maxX;
                            }

                        }
                        
                        c.realign();
                        c.shiftPos();
                    }
                }
            
            if (this.autoResize){
                this.realign();
                this.shiftPos();
            }
          
        }
       
    }, null, false);

    //destroy()
    e.rawnewmember("destroy", function() {
        if (typeof this != "instance"){
            if (this.rawin("preDestroy") && this.preDestroy != null){
                this.preDestroy();
            }
            if (this.isWrapped()){
                foreach (line in this.metadata.lines) {
                    UI.Label(line).destroy();
                }
                this.metadata.lines.clear();
            }
        }
        this.UI.Delete(this);
    }, null, false);

     
      //showTooltip()
    e.rawnewmember("showTooltip", function() {
     
        this.UI.showTooltip(this);
    }, null, false);

    //clearTooltip()
     e.rawnewmember("clearTooltip", function() {
        if (this.rawin("tooltip") && this.tooltip != null){
            if (this.tooltipVisible != null && this.tooltipVisible  ){
                this.UI.DeleteByID(this.id+"::tooltip");
                this.tooltipVisible = false;
            }
        }
       
    }, null, false);

    //fadeIn()
    e.rawnewmember("fadeIn", function(callback = {}) {
    
        local e = this; 
        local id = e.id;
        local alpha = e.metadata.rawin("oldAlpha") ? e.metadata.oldAlpha : e.Alpha;
        e.show(false);
        if (e.fadeStep == null){
            e.fadeStep = 15;
        }
        if (e.fadeHigh == null){
            e.fadeHigh = alpha;
        }
       
        
        this.fadeInTimer = Timer.Create(::getroottable(), function(text) {
            if (e.Alpha < e.fadeHigh){ 
                e.Alpha+=e.fadeStep; 
            }else {
                Timer.Destroy(e.fadeInTimer);
                if (callback.rawin("onFinish")){
                    callback.onFinish();
                }
            }
        }, 1, 0, id+"fadeInTimer"+Script.GetTicks());  
    }, null, false);

      //fadeOut() 
    e.rawnewmember("fadeOut", function(callback = {}) { 
        local e = this;  
        local id = e.id; 
        e.metadata["oldAlpha"] <- e.Alpha;
       
        if (e.fadeStep == null){
            e.fadeStep = 15;
        }
        if (e.fadeLow == null){
            e.fadeLow = 0;
        }
      
        this.fadeOutTimer = Timer.Create(::getroottable(), function(text) {
            if (e.Alpha > e.fadeLow){
                e.Alpha-=e.fadeStep;
            }else {
                e.hide();
                Timer.Destroy(e.fadeOutTimer);
                if (callback.rawin("onFinish")){
                    callback.onFinish();
                }
            }
        }, 1,0, id+"fadeOutTimer"+Script.GetTicks());
    }, null, false);

    //hide() 
     e.rawnewmember("hide", function() {
         if (this.Position != null && (this.hidden == null || this.hidden == false) ){
         
             this.hidden = true;
             this.RemoveFlags(GUI_FLAG_VISIBLE);
             if (this.isWrapped()){
                foreach (line in this.metadata.lines) { 
                    UI.Label(line).hide();
                }
               
            }
         }
    }, null, false);

    //show()
     e.rawnewmember("show", function(restoreAlpha = true) {
         
        this.hidden = false;
       
        this.AddFlags(GUI_FLAG_VISIBLE);
        if (this.Alpha == 0  && restoreAlpha){
            local alpha = this.metadata.rawin("oldAlpha") ? this.metadata.oldAlpha : 255;
            this.Alpha = alpha;
        }
        if (this.isWrapped()){
            foreach (line in this.metadata.lines) {
                UI.Label(line).show();
            }
           
        }
         
    }, null, false);

    //realign()
     e.rawnewmember("realign", function() {
        this.UI.align(this);
         if (this.isWrapped()){
            foreach (line in this.metadata.lines) {
                 this.UI.align(UI.Label(line));
            }
               
        }
    }, null, false);


   
    //click()
     e.rawnewmember("click", function() {
        if (this.onClick != null){
            this.onClick();
        }
    }, null, false);

     //getFirstParent()
     e.rawnewmember("getFirstParent", function() {
       if (this.parents.len() >0){
           return this.parents[this.parents.len()-1];
       }
       return null;
    }, null, false);

      //getLastParent()
     e.rawnewmember("getLastParent", function() {
       if (this.parents.len() >0){
           return this.parents[0];
       }
       return null;
    }, null, false);

    //addPreset(preset)
     e.rawnewmember("addPreset", function(p) {
        if (!p.rawin("id") ||  p.id == null  && p.rawin("name") ){

            if (this.presetsList == null){
                this.presetsList = [];
                this.presets =[];
            }

            if (this.presets.find(p.name) == null) {
                this.presetsList.push(p);
                this.presets.push(p.name);
                this =  this.UI.applyElementProps(this,p);
            }
        }
    }, null, false); 
       

        //resetPosition()
       e.rawnewmember("resetPosition", function() {
           if (this.metadata.ORIGINAL_POS != null){
               this.Position.X = this.metadata.ORIGINAL_POS.X;
               this.Position.Y = this.metadata.ORIGINAL_POS.X;
           }
       })

       //getWrapper()
       e.rawnewmember("getWrapper", function() {
            local wrapper = null; 
            if (this.parents.len() == 0){ 
                wrapper = ::GUI.GetScreenSize(); 
            }else{ 
                local lastID = this.parents[this.parents.len()-1];
            
                local parent = ::UI.findById(lastID);
                wrapper =  parent == null ? ::GUI.GetScreenSize() : parent.Size;
            }
            return wrapper;
       })

        //getParent
        e.rawnewmember("getParent", function() {
            if (this.parents.len() == 0){ 
               return null;
            }else{ 
                local lastID = this.parents[this.parents.len()-1];
            
                local parent = ::UI.findById(lastID);
               return parent;
            }
            
       })
      
         //hasWrapOptions()
       e.rawnewmember("hasWrapOptions", function() {
            return this.rawin("wrapOptions") && this.wrapOptions != null;
       })

        //setText()
       e.rawnewmember("setText", function(t) {
            this.set("Text",t);
       })


         //isWrapped()
       e.rawnewmember("isWrapped", function() {
           return (this.rawin("metadata") && this.metadata != null && this.metadata.rawin("lines") && this.metadata.lines != null &&  this.metadata.lines.len()> 0 && (this.hasWrap() )  );
       })
 
         //set(fieldName, value)
       e.rawnewmember("set", function(fieldName, value) {
            local firstText = this.Text;
            this[fieldName] = value;
            if (fieldName == "Text" || fieldName == "FontSize"){
                this.Size.X = this.TextSize.X+10;
                this.Size.Y = this.TextSize.Y+4;
            }

             if (this.metadata.originalObject.rawin(fieldName)){
                    this.metadata.originalObject[fieldName] = value;
                }else {
                    this.metadata.originalObject[fieldName] <- value; 
            }

            
       
           if (this.isWrapped()){
               
                if (fieldName == "Text" || fieldName == "FontSize" || fieldName == "FontName"){
                    local text = firstText;
                    foreach (line in this.metadata.lines) {
                        local l = UI.Label(line);
                        text += l.Text;
                        l.destroy();
                       
                    }
                   
                    if (fieldName == "FontSize"){ 
                       this.Text = text;
                    }
                    this.metadata.lines.clear();
                    local parentID = this.parents[this.parents.len()-1];
                    if (parentID != null){
                        local parent = UI.Canvas(parentID);
                        if (parent == null){
                            parent = UI.Window(parentID);
                        }
                        this.wrapText(parent, this, parent.Size.X-10)
                    }
                }else{   
                     foreach (line in this.metadata.lines) {
                        try {
                            UI.Label(line)[fieldName] = value;
                        } catch(e){}
                        
                    }
                }

              
               
           }
       });

       //hasWrap()
       e.rawnewmember("hasWrap", function() {
            return this.rawin("wrap") && this.wrap != null && this.wrap == true;
       });
       
       //forceWrap()
       e.rawnewmember("forceWrap", function() {
             local lastID = this.parents[this.parents.len()-1];
          
            if (lastID != null){
                local parent = ::UI.findById(lastID);
                this.wrapText(parent, this, parent.Size.X-10)
            }
       });
    

      //wrapText(parent, firstLabel, size)
       e.rawnewmember("wrapText",function (parent, firstlabel,  size){ 
       
        local width = size;
        if (this.hasWrapOptions()){
            if (this.wrapOptions.rawin("maxWidth")){
                width = this.wrapOptions.maxWidth;
            }
        }   
        local rem = [];
        local resized = false;
        while (this.Position.X + this.TextSize.X > width){
            
        
            local lastLetter =  this.Text.slice( this.Text.len()-1, this.Text.len());
            local remaining = this.Text.slice(0,this.Text.len()-1)
            this.set("Text", remaining);
        
            rem.push(lastLetter);
            resized = true;
        }  
        if (resized){
           
            rem.reverse();
            local obj = this.metadata.originalObject;
            obj.id = obj.id+"::line"+ (firstlabel.metadata.lines.len()+1);
            obj.Text = rem.reduce(@(p, c) p + c);
            if (!obj.rawin("move")){
                obj["move"] <- {};
            }else{
                obj.move = {};
            }

            local line = UI.Label(obj);
            
            line.set("Text", obj.Text);
            local lineSpacing = 0;
            if (firstlabel.hasWrapOptions()){
                if (firstlabel.wrapOptions.rawin("lineSpacing")){
                    lineSpacing = firstlabel.wrapOptions.lineSpacing;
                }
            }
          
            line.Position.Y = this.Position.Y;
            line.Position.Y += this.TextSize.Y+5 + lineSpacing;
            firstlabel.metadata.lines.push(line.id);
            line.wrapText(parent,firstlabel,size);
            parent.add(line);
          

        }
        return resized;
    });

      //applyRelativeSize()
       e.rawnewmember("applyRelativeSize", function() {
           ::UI.applyRelativeSize(this);
       });

     //attachChild(p)
     e.rawnewmember("attachChild", function(p) {
        local t = typeof this;
        local ct = typeof p;

         if (this.id != null && p.id != this.id ) {
                 
                
            local list =  this.UI.mergeArray(this.parents, this.id);  
            if (this.childLists.find(p.metadata.list) == null) {
                this.childLists.push(p.metadata.list); 
            }
            if (p.metadata == null){ 
                p.metadata <- { parentPos = this.Position };
            }else{ 
                p.metadata["parentPos"] <- this.Position;
            } 
            p.metadata["parentID"] <- this.id; 
            p.parents = list;
            this.AddChild(p);
            if (p.rawin("RelativeSize") && p.RelativeSize != null) {
                 ::UI.applyRelativeSize(p); 
            }
            if (p.rawin("align") && p.align != null && !p.isBorder()){
                p.realign();
            }
           
            if ( this.autoResize  &&  !p.hasWrap() && !p.isBorder() ){ 
                local adjusted = false;
              
                if ( p.Position.X+p.Size.X > this.Size.X){
                    this.Size.X = p.Position.X+p.Size.X;
                    adjusted = true;
                }
                if ( p.Position.Y+p.Size.Y > this.Size.Y){
                    this.Size.Y = p.Position.Y+p.Size.Y;
                    adjusted = true;
                } 
               if (adjusted){
                    this.realign(); 
                    this.shiftPos(); 

                     foreach (i, c in this.getChildren()) {
                        if (!c.rawin("className")) {
                            c.resetPosition();
                            c.realign();
                            c.shiftPos();
                        }
                    }
                }
           
            }
            if (p.rawin("shiftPos") && p.shiftPos != null){
                p.shiftPos(); 
            }
            if (p.hasWrap() && !p.delayWrap){
               p.wrapText(this,p,this.Size.X-10)
            }
           
        }
    }, null, false);
 

    //add(e)
     e.rawnewmember("add", function(p) {
        
        if ( p.rawin("className")){ 
            if (p.className == "InputGroup"){ 
                p.attachParent(this,0);
            } else if (p.className == "GroupRow"){   
               p.parentID = this.id;
               p.calculatePositions(); 
            } else { 
               
                 p = ::UI.Canvas(p.id); 
                this.attachChild(p);
            }
           

        }else{ 
           
           p.parentSize = this.Size;
           this.attachChild(p);
        }
        
    }, null, false);

  
     //shift()
     e.rawnewmember("shiftPos", function() {
       this.UI.shift(this);
        if (this.isWrapped()){
            foreach (line in this.metadata.lines) {
                 this.UI.shift(UI.Label(line));
           }
               
        }
    }, null, false);

    //removeChildren()
     e.rawnewmember("removeChildren", function() {
        this.UI.removeChildren(this);
    }, null, false);


    //getChildren()
     e.rawnewmember("getChildren", function() {
        return this.UI.getChildren(this);
    }, null, false);

    //removePreset(preset)
     e.rawnewmember("removePreset", function(name) {
        if (id!=null){
            if (presets !=null) {
                local idx = this.presets.find(name);
                if (idx != null){
                    this.presets.remove(idx);
                }
                if  (this.presetsList != null) {
                     local index = null;

                    foreach (i, p in this.presetsList) {
                        if (p.name ==name){
                            index = i;
                            break;
                        }
                    }
                    
                    if (index != null) {
                        this.presetsList.remove(index);
                        this.applyPresets();
                    }
                }
            }
        }
    }, null, false);

     //applyPresets()
     e.rawnewmember("applyPresets", function() {
        foreach (i, p in this.presetsList) {
            this =  this.UI.applyElementProps(this,p);
        }
    }, null, false);

     //hasParents()
     e.rawnewmember("hasParents", function() {
       return this.parents.len() > 0;
    }, null, false);

    //hasPreset(name)
     e.rawnewmember("hasPreset", function(name) {
       if (this.presets ==  null) {
           return false;
       }else{
           return (this.presets.find(name) != null);
       }
    }, null, false);
}