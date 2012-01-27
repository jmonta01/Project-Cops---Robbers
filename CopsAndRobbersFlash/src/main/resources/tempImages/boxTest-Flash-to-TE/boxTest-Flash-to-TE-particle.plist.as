package
{
	// import quick box2d
	import com.actionsnippet.qbox.*;

    // other stuff
    import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;


    public class PhysicsData extends Object
	{
		// ptm ratio
        public var ptm_ratio:Number = 2;
		
		// the physcis data 
		var dict:Dictionary;
		
        public function createBody(name:String, sim:QuickBox2D, xPos:Number, yPos:Number):QuickObject
        {
			var fixture:Array = dict[name][0];

           	return sim.addPoly({
                        x:xPos, y:yPos, 
                        density:fixture[0], 
                        friction:fixture[1], 
                        restitution:fixture[2],
                        categoryBits: fixture[3],
                        maskBits:fixture[4],
                        groupIndex: fixture[5],
                        verts:fixture[8],
						skin:getDefinitionByName(name)
                        });							
			}
		
        public function PhysicsData(): void
		{
			dict = new Dictionary();
			

			dict["boxTest-Flash-to-TE-particle"] = [

										[
											// density, friction, restitution
                                            2, 0, 0,
                                            // categoryBits, maskBits, groupIndex, isSensor
											1, 65535, 0, false,
											'POLYGON',
											[

                                                [   9.75/ptm_ratio, 14/ptm_ratio  ,  29.5/ptm_ratio, 1.5/ptm_ratio  ,  49.5/ptm_ratio, 1.5/ptm_ratio  ,  49.5/ptm_ratio, 51.5/ptm_ratio  ,  39.25/ptm_ratio, 55/ptm_ratio  ,  1.5/ptm_ratio, 36.5/ptm_ratio  ]
											]
										]

									];

		}
	}
}
