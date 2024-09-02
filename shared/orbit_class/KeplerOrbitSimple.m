classdef KeplerOrbitSimple
    % Orbit Class - Kepler Simple 2-Body
    % Desc: This class is a definition for holding orbital parameters, orbit generation parameters,
    % and associated methods in order to succintly organize orbit generation and its outputs.

    properties
        % Keplerian Orbital Elements
        semi_major_axis         double     % [DIM: m]
        inclination             double     % [DIM: deg]     
        RAAN                    double     % [DIM: deg]
        true_anomaly            double     % [DIM: deg]
        argument_of_perigee     double     % [DIM: deg]
        eccentricity            double     % [DIM: N/A]

        % Propagation Properties
        orbit_period            double     % [DIM: sec]
        dt                      double     % [DIM: sec]
        t0                      double     % [DIM: sec]
        tend                    double     % [DIM: sec]
        x0              (1,6)   double     % [DIM: (1,:3) m, (1,3:6) m/s] - CARTESIAN COORDS
    end
    methods

        % Class Construction Method
        % Desc: Method defined to instantiate the object with initial properties
        % Inputs:
        %   sma: semi-major axis    [m]
        %   inc: inclination        [deg]
        %   raan: Right Ascension of Ascending Node     [deg]
        %   t_anomaly: True Anomaly                     [deg]
        %   arg_perigee: Argument of Perigee            [deg]
        %   ecc: Eccentricity                           [nil]
        %
        % Outputs:
        %   obj: Instance of KeplerOrbitSimple class with keplerian orbital elements initialized
        %

        function obj = KeplerOrbitSimple(sma, inc, raan, t_anomaly, arg_perigee, ecc)
            obj.semi_major_axis = sma;
            obj.inclination = inc;
            obj.RAAN = raan;
            obj.true_anomaly = t_anomaly;
            obj.argument_of_perigee = arg_perigee;
            obj.eccentricity = ecc;
        end

        % Orbit Propagation Method
        % Desc: Method for propagating orbit based on class defined parameters
        % Inputs:
        %   orbit_object: The KeplerOrbitSimple that contain parameters used to generate orbit
        % 
        % Outputs:
        %   [tx, xn]: The time and state vector of numerical integration of equation of motion 
        %   [sec, (:,:3) m, (:,3:6) m/s] -> Dimensions of Outputs
        %

        function [tn, xn] = propagate_simple_kepler(orbit_object)

            % Set numerical integrator options
            options = odeset('Reltol', 1E-12, 'AbsTol', 1E-12, 'InitialStep', orbit_object.dt, 'MaxStep', orbit_object.dt);

            % Generate orbit
            [tn, xn] = ode45('simple_kepler_orbit_pde', [orbit_object.t0, orbit_object.tend], orbit_object.x0, options);
        end

    end
end