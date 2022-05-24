FROM uselagoon/node-16-builder:latest as builder
COPY package.json package-lock.json /app/
RUN npm install

FROM uselagoon/node-16:latest
COPY --from=builder /app/node_modules /app/node_modules
COPY . /app/

ARG LAGOON_GIT_BRANCH

# next.js needs env vars at build time so we need to inject '.lagoon.env.*' files for loading client-side NEXT_PUBLIC_ vars.
ARG LAGOON_GIT_BRANCH

RUN if [ "$LAGOON_GIT_BRANCH" = "dev" ] ; then npm run dev:build ; elif [ "$LAGOON_GIT_BRANCH" = "staging" ] ; then npm run staging:build ; elif [ "$LAGOON_GIT_BRANCH" = "staging-2" ] ; then npm run staging-2:build ; elif [ "$LAGOON_GIT_BRANCH" = "staging-3" ] ; then npm run staging-3:build ; elif [ "$LAGOON_GIT_BRANCH" = "main" ] ; then npm run prod:build ; else chmod +x /app/lagoon/inject-env-vars.sh && sh ./lagoon/inject-env-vars.sh && npm run build ; fi
RUN fix-permissions /app/build

EXPOSE 3000

CMD ["npm", "run", "start"]
