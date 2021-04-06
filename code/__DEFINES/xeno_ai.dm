#define XENO_CALCULATING_PATH(X) (X in SSxeno_pathfinding.hash_path)

#define DIRECTION_CHANGE_PENALTY 2
#define NO_WEED_PENALTY 2
#define DISTANCE_PENALTY 1
#define ASTAR_COST_FUNCTION(n) (abs(n.x - target.x)+abs(n.y - target.y))

#define DOOR_PENALTY 3
#define OBJECT_PENALTY 20
#define HUMAN_PENALTY 4
#define WINDOW_FRAME_PENALTY 25
#define BARRICADE_PENALTY 50
#define WALL_PENALTY 50

/*
  PROBABILITY CALCULATIONS ARE HERE
*/

#define XENO_SLASH 80

#define RETREAT_AT_PLASMA_LEVEL 0.2
#define RETREAT_AT_HEALTH_LEVEL 0.4

// Warrior

/// How likely should it be that you lunge when off cooldown?
#define WARRIOR_LUNGE 40
/// How far should the warrior be before they attempt to lunge?
#define WARRIOR_LUNGE_RANGE 7
/// How likely should it be that you punch when off cooldown?
#define WARRIOR_PUNCH 15
/// How likely should it be that you fling when off cooldown?
#define WARRIOR_FLING 25

// Spitter

#define SPITTER_SPIT 90
#define SPITTER_FRENZY 20
#define SPITTER_SPRAY 80
#define SPITTER_SPRAY_SPIT_PERIOD 3 SECONDS

// Sentinel

#define SENTINEL_SPIT 90

// Runner

#define RUNNER_POUNCE 75
#define RUNNER_POUNCE_RANGE 7
#define RUNNER_GRAB 100

// Lurker

#define LURKER_POUNCE 75
#define LURKER_POUNCE_RANGE 7
#define LURKER_INVISIBLE 100
#define LURKER_POWER_SLASH 100
